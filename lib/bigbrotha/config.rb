module BigBrotha

  class Config

    #The argument :timing indicates whether the callback is to be run :before, :after the event(:save, :create, :update).
    def add(model, creator_column, columns = [], timing, event)
      raise NotActiveRecordModel.new unless model < ActiveRecord::Base
      columns = Array(columns)
      event = event.to_sym
      timing = timing.to_sym

      model.set_callback event, timing, ->(obj) {
        changed_columns = event == :create ? columns : columns.map { |c| c.to_s } & obj.changed
        censored_texts = {}

        changed_columns.each do |column|
          content_column = model.to_s + "." + column.to_s
          creator = Config.get_value(obj, creator_column)
          column_value = Config.get_value(obj, column)
          censored_text = Censor.censor_text!(creator, column_value, content_column)
          censored_texts[column] = censored_text
        end

        if timing == :after
          obj.update_columns(censored_texts)
        elsif timing == :before
          censored_texts.each {|k,v| obj.send(k.to_s+"=", v)}
        end
      }

    end

    def self.get_value(obj, column)
      column = column.to_sym
      return obj if column == :self
      obj.respond_to?(column) ? obj.send(column) : nil
    end
  end

end

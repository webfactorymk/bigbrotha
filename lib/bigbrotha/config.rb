module BigBrotha

  class Config

    #The forth argument (timing) indicates whether the callback is to be run :before, :after, or :around the event(:save, :create ...).
    def add(model, creator_column, columns = [], timing, event)
      raise NotActiveRecordModel.new unless model < ActiveRecord::Base
      columns = Array(columns)
      columns.each do |column|
        model.set_callback event.to_sym, timing.to_sym, ->(obj) {
          column = model.to_s + "." + column.to_s
          creator = Config.get_value(obj, creator_column)
          column_value = Config.get_value(obj, column)
          censored_text = Censor.censor_text!(creator, column_value, column)

          obj.send(column+"=", censored_text) #update the object's column with the censored word
        }
      end
    end

    def self.get_value(obj, column)
      column = column.to_sym
      return obj if column == :self
      obj.respond_to?(column) ? obj.send(column) : nil
    end
  end

end

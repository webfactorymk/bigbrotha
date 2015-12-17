
BigBrotha.configure do |config|

  #The first argument (model) should be the ActiveRecord model that the callback should be appended to.
  #The second argument (creator) should be the name of the field in the model that will be saved as the creator of the content with taboo.
  #The third argument (columns) should be the name/ names of the columns in the model that need to be checked for taboos.
  #The fourth argument (timing) indicates whether the callback is to be run :before, :after the event.
  #The fifth argument (event) indicates around which event (:save, :update, :create) the callback is to be run.

 # Example configuration: config.add(User, :self, [:username, :comment], :before, :save)
end

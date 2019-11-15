class Event < ActiveRecord::Base
    has_many :user_events
    has_many :users, through: :user_events

    def create(name = nil, date = nil, url = nil)
        self.create(name: name, date: date, event_type: url)
    end 
end
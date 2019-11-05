class Status < ApplicationRecord
    validates :title, presence: true
    has_many :features
end

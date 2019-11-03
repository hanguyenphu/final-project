class Contact < ApplicationRecord
    validates :header, :content, :email, :phone, :address, presence: true
end

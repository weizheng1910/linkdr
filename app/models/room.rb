class Room < ApplicationRecord
belongs_to :match
has_many :room_messages, dependent: :destroy,
                         inverse_of: :room


end

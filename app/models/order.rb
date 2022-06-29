# == Schema Information
#
# Table name: orders
#
#  id               :bigint           not null, primary key
#  comment          :string
#  coupon           :string
#  delivery_address :string
#  latitude         :float
#  longitude        :float
#  order_detail     :string
#  save_locations   :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#
class Order < ApplicationRecord
  belongs_to :user
end

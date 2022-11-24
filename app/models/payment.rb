# class Payment < ApplicationRecord
#   attr_accessor :card_number, :card_cvc, :card_expires_month, :card_expires_year

#   belongs_to :user

#   with_options on: :create do |payment|
#     payment.validate :card_details
#     payment.after_validation :process_payment
#   end

#   def self.month_options
#     Date::MONTHNAMES.compact.each_with_index.map { |name, i| ["#{i+1} - #{name}", i+1]}
#   end

#   def self.year_options
#     (Date.today.year..(Date.today.year+10)).to_a
#   end

#   private

#   def card_details
#     Stripe.api_key = Rails.configuration
#       .application['STRIPE_TEST_PUBLISHABLE_KEY']

#     begin
#       response = Stripe::Token.create({
#         card: {
#           number: card_number,
#           cvc: card_cvc,
#           exp_month: card_expires_month,
#           exp_year: card_expires_year,
#         }
#       })

#       self.token = response.id
#     rescue => error
#       errors.add(:card_number, error.message)
#     end
#   end

#   def process_payment
#     Stripe.api_key = Rails.configuration
#       .application['STRIPE_TEST_SECRET_KEY']

#     customer = Stripe::Customer.create email: user.email, card: token

#     Stripe::Charge.create customer: customer.id,
#       amount: 100,
#       description: 'Premium',
#       currency: 'nzd'
#   end
# end

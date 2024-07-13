class LoanRequest < ApplicationRecord
  attr_accessor :current_step

  STEP_VALIDATIONS = {
    '1' => [:address],
    '2' => [:loan_term],
    '3' => [:purchase_price],
    '4' => [:repair_budget],
    '5' => [:arv],
    '6' => [:first_name, :email, :phone]
  }.freeze

  validate :step_validations
  validates :loan_term, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 12, message: "must be between 1 and 12 months" }, if: -> { on_step?('2') }
  validates :purchase_price, numericality: { only_integer: true, greater_than: 0, message: "must be a positive number" }, if: -> { on_step?('3') }
  validates :repair_budget, numericality: { only_integer: true, greater_than: 0, message: "must be a positive number" }, if: -> { on_step?('4') }
  validates :arv, numericality: { only_integer: true, greater_than: 0, message: "must be a positive number" }, if: -> { on_step?('5') }
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }, if: -> { on_step?('6') }

  def step_validations
    return unless current_step

    STEP_VALIDATIONS[current_step].each do |attribute|
      errors.add(attribute, :blank) if send(attribute).blank?
    end
  end

  def first_step?
    current_step == '1'
  end

  def last_step?
    current_step == '6'
  end

  def next_step
    self.current_step = (current_step.to_i + 1).to_s
  end

  def previous_step
    self.current_step = (current_step.to_i - 1).to_s
  end

  def all_steps_valid?
    (1..6).all? do |step|
      self.current_step = step.to_s
      valid?
    end
  end

  def calculate_max_fundable_amount
    max_purchase_price_loan = purchase_price * 0.9
    max_arv_loan = arv * 0.7
    [max_purchase_price_loan, max_arv_loan].min
  end

  def calculate_interest_expense(loan_amount)
    monthly_interest_rate = 0.13 / 12
    total_interest = loan_amount * monthly_interest_rate * loan_term
    total_interest
  end

  def calculate_profit
    loan_amount = calculate_max_fundable_amount
    interest_expense = calculate_interest_expense(loan_amount)
    profit = arv - loan_amount - interest_expense
    profit
  end

  private

  def on_step?(step)
    current_step == step
  end
end

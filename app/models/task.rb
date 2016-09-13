class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :status, presence: true

  delegate :user, to: :project

  enum status: [:unimportant, :normal, :important, :very_important]

  def order
    Task.statuses[status]
  end

  def order_up
    return false if very_important?
    assign_attributes(status:order+1)
  end

  def order_down
    return false if unimportant?
    assign_attributes(status:order-1)
  end

  def update(attributes)
    send(attributes[:order]) if order_methods.include?(attributes[:order])
    super(attributes.except(:order))
  end

  private
  def order_methods
    ['order_up','order_down']
  end
end

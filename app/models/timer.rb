class Timer < ApplicationRecord
  belongs_to :type
  belongs_to :user

  # Validations
  validates_presence_of :user_id, :type_id, :start, :finish
  validate :check_dates

  after_create :set_duration

  private

  def check_dates
    if start > finish
      errors.add(:start, t("activerecord.errors.models.timer.attributes.start"))
    end
  end

  def set_duration
    self.update(duration: (finish - start) / 60.0)
  end
end

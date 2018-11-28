class Timer < ApplicationRecord
  belongs_to :type
  belongs_to :user

  after_create :set_duration

  private

  def set_duration
    self.update(duration: (finish - start) / 60.0)
  end
end

class CustomerMailer < ActiveRecord::Base

  def to_liquid
    CustomerMailDrop.new(self)
  end
end

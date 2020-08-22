class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if self.valid? && sender.balance > self.amount && self.status == "pending"
      @status = "complete"
      sender.balance -= amount
      receiver.balance += amount
    else
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete"
      @status = "reversed"
      receiver.balance -= amount
      sender.balance += amount
    end
  end
end

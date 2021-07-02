# == Schema Information
#
# Table name: dog_rental_requests
#
#  id         :bigint           not null, primary key
#  end_date   :date             not null
#  start_date :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  dog_id     :integer          not null
#
# Indexes
#
#  index_dog_rental_requests_on_dog_id  (dog_id)
#
class DogRentalRequest < ApplicationRecord
    STATUS_STATES = %w(APPROVED DENIED PENDING).freeze
    validates :end_date, :start_date, :status, :dog_id, presence:true
    validates :status, inclusion: STATUS_STATES
    validate :start_before_end
    validate :availability
    validate :starts_in_future, on: :create
    belongs_to :dog

    def approve!
        raise "Not pending!" unless self.status = "PENDING"
        transaction do
            self.status = "APPROVED"
            self.save!
            overlapping_pending_requests.each {|e| e.update(status:"DENIED")}
        end
    end
    
    def approved?
        self.status == 'APPROVED'
    end
    
    def denied?
        self.status == 'DENIED'
    end
    
    def pending?
        self.status == 'PENDING'
    end

    def deny!
        self.status = 'DENIED'
        self.save!
    end

    def overlapping_requests
        DogRentalRequest
        .where.not(id:self.id)
        .where(dog_id:self.dog_id)
        .where.not("start_date > ? OR end_date < ?", self.end_date, self.start_date)
    end

    def overlapping_pending_requests
        overlapping_requests.where(status:"PENDING")
    end

    def overlapping_approved_requests
        overlapping_requests.where(status:"APPROVED")
    end

    def availability
        return if self.denied?
        errors.add(:base, 'Request conflicts with an existing approved request') unless overlapping_approved_requests.empty?
    end

    def start_before_end
        return if start_date < end_date
        errors.add :start_date, 'must come before end date'
        errors.add :end_date, 'must come after start date'
    end

    def starts_in_future
        return if start_date >= Date.current        
        errors.add :start_date, "cannot be in the past"
    end

end

class Build < ActiveRecord::Base
  belongs_to :repository

  STATUSES = ['queued', 'pulling', 'building', 'pushing', 'complete']
  validates_inclusion_of :status, :in => STATUSES,
                         :message => "{{value}} must be in #{STATUSES.join ','}"

end

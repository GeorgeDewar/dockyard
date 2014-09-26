class Build < ActiveRecord::Base
  belongs_to :repository

  STATUSES = ['queued', 'pulling', 'building', 'pushing', 'failed', 'complete']
  validates_inclusion_of :status, :in => STATUSES,
                         :message => "{{value}} must be in #{STATUSES.join ','}"

  after_initialize do
    if self.new_record?
      self.status = 'queued'
    end
  end

  def execute
    status = 'pulling'
    Shell.run repository.path, "git pull"
    status = 'building'
    Shell.run repository.path, "docker build -t #{repository.docker_uri} ."
    status = 'pushing'
    Shell.run repository.path, "docker push #{repository.docker_uri}"
    status = 'complete'
  end

end

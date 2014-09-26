class Repository < ActiveRecord::Base
  has_many :builds

  def repos_path
    '/home/george/dockyard/repos'
  end

  def path
    "#{repos_path}/#{id}"
  end

  def initialise # not to be confused with initialize, the constructor
    Shell.run repos_path, "git clone #{repo_uri} #{id}"
    self.initialised = true
    save!
  end

  def build(tag)
    build = builds.create(tag: tag)
    build.execute
  end
end

class Repository < ActiveRecord::Base
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

  def build
    Shell.run path, "git pull"
    Shell.run path, "docker build -t #{docker_uri} ."
    Shell.run path, "docker push #{docker_uri}"
  end
end

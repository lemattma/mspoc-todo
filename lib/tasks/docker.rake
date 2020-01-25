namespace :docker do
  desc "Build docker image"
  task :build_image do
    TAG = `git rev-parse --short HEAD`.strip

    puts "Building Docker image"
    sh "docker build -t martinmirandac/mspoc-todo:#{TAG} ."

    puts "Done"
  end

  desc "Push docker images to DockerHub"
  task :push_image do
    TAG = `git rev-parse --short HEAD`.strip

    puts "Building Docker image"
    sh "docker build -t martinmirandac/mspoc-todo:#{TAG} ."

    IMAGE_ID = `docker images | grep martinmirandac\/mspoc-todo | head -n1 | awk '{print $3}'`.strip

    puts "Tagging latest image"
    sh "docker tag #{IMAGE_ID} martinmirandac/mspoc-todo:latest"

    puts "Pushing Docker image"
    sh "docker push martinmirandac/mspoc-todo:#{TAG}"
    sh "docker push martinmirandac/mspoc-todo:latest"

    puts "Done"
  end
end

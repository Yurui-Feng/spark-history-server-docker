$env:SPARK_VERSION = if ($env:SPARK_VERSION) { $env:SPARK_VERSION } else { "3.5.0" }
$env:SPARK_HOME = if ($env:SPARK_HOME) { $env:SPARK_HOME } else { "/opt/spark" }
$env:DOCKER_HUB_USER = if ($env:DOCKER_HUB_USER) { $env:DOCKER_HUB_USER } else { "rangareddy1988" }
$env:DOCKER_IMAGE_NAME = if ($env:DOCKER_IMAGE_NAME) { $env:DOCKER_IMAGE_NAME } else { "spark-history-server" }
$LATEST_TAG_NAME = "latest"

$SHS_DOCKER_IMAGE_NAME_LATEST = "${env:DOCKER_HUB_USER}/${env:DOCKER_IMAGE_NAME}:${LATEST_TAG_NAME}"
$SHS_DOCKER_IMAGE_NAME_SPARK = "${env:DOCKER_HUB_USER}/${env:DOCKER_IMAGE_NAME}:${env:SPARK_VERSION}"

Write-Host "Building the Docker <${env:DOCKER_IMAGE_NAME}> image using Spark <${env:SPARK_VERSION}> version"

# Check if running on ARM64
if ($env:PROCESSOR_ARCHITECTURE -eq "ARM64" -and ($args[0] -eq "run" -or $args[0] -eq "build")) {
    $env:DOCKER_DEFAULT_PLATFORM = "linux/amd64"
}

# Building the Docker image
docker build `
    -t ${SHS_DOCKER_IMAGE_NAME_LATEST} `
    -t ${SHS_DOCKER_IMAGE_NAME_SPARK} `
    --build-arg spark_version=${env:SPARK_VERSION} `
    --build-arg spark_home=${env:SPARK_HOME} `
    -f Dockerfile . 
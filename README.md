# docker-dockerspec

[![GitHub Actions Status](../../workflows/Build%20and%20Publish%20to%20Docker%20Hub/badge.svg)](../../actions)

An image intended to run Docker image tests using RSpec and ServerSpec.

## Contents

This image contains tools for testing Docker images:
* [iboss/alpine](https://github.com/iBossOrg/docker-alpine) as a base image.
* [Docker](https://docs.docker.com/engine/) provides a Docker command line tools
  and engine.
* [Docker Compose](https://docs.docker.com/compose/) provides a Docker Compose
  command line tools.
* [RSpec](http://rspec.info) provides a Ruby testing framework.
* [ServerSpec](http://serverspec.org) provides a server testing framework for
  RSpec.
* [Docker API](https://github.com/swipely/docker-api) provides an interface for
  Docker Remote API.
<!--
* [Dockerspec](https://github.com/zuazo/dockerspec) provides Docker plugin for ServerSpec.
-->

## Usage

You can test your container with commands:
```bash
cd MY_IMAGE
docker run -d --name=my_container MY_IMAGE
docker run -t \
  -e CONTAINER_NAME=my_container \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $PWD:$PWD \
  -w $PWD \
  --rm \
  iboss/dockerspec --format=doc
```

## Reporting Issues

Issues can be reported by using [GitHub Issues](/../../issues). Full details on
how to report issues can be found in the [Contribution Guidelines](CONTRIBUTING.md).

## Contributing

Clone the GitHub repository into your working directory:
```bash
git clone https://github.com/ibossorg/docker-dockerspec
```

Use the command `make` in the project directory:
```bash
make all                      # Build a new image and run the tests
make ci                       # Build a new image and run the tests
make build                    # Build a new image
make rebuild                  # Build a new image without using the Docker layer caching
make vars                     # Display the make variables
make up                       # Remove the containers and then run them fresh
make create                   # Create the containers
make start                    # Start the containers
make wait                     # Wait for the start of the containers
make ps                       # Display running containers
make logs                     # Display the container logs
make logs-tail                # Follow the container logs
make shell                    # Run the shell in the container
make test                     # Run the tests
make test-shell               # Run the shell in the test container
make restart                  # Restart the containers
make stop                     # Stop the containers
make down                     # Remove the containers
make clean                    # Remove all containers and work files
make docker-pull              # Pull all images from the Docker Registry
make docker-pull-baseimage    # Pull the base image from the Docker Registry
make docker-pull-dependencies # Pull the project image dependencies from the Docker Registry
make docker-pull-image        # Pull the project image from the Docker Registry
make docker-pull-testimage    # Pull the test image from the Docker Registry
make docker-push              # Push the project image into the Docker Registry
```

Please read the [Contribution Guidelines](CONTRIBUTING.md), and ensure you are
signing all your commits with [DCO sign-off](CONTRIBUTING.md#developer-certification-of-origin-dco).

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available,
see the [tags on this repository](/../../tags).

## Authors

* [Petr Řehoř](https://github.com/prehor) - Initial work.

See also the list of [contributors](../../contributors)
who participated in this project.

## License

This project is licensed under the Apache License, Version 2.0 - see the
[LICENSE](LICENSE) file for details.

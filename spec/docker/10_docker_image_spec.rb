require "docker_helper"

### DOCKER_IMAGE ###############################################################

describe "Docker image", :test => :docker_image do
  # Default Serverspec backend
  before(:each) { set :backend, :docker }

  ### DOCKER_IMAGE #############################################################

  describe docker_image(ENV["DOCKER_IMAGE"]) do
    # Execute Serverspec commands locally
    before(:each) { set :backend, :exec }
    it { is_expected.to exist }
  end

  ### OS #######################################################################

  describe "Operating system" do
    context "family" do
      subject { os[:family] }
      it { is_expected.to eq("alpine") }
    end
  end

  ### PACKAGES #################################################################

  describe "Packages" do

    # [package, version, installer]
    packages = [
      "git",
      "make",
      "nmap",
      "nmap-nping",
      "nmap-nselibs",
      "nmap-scripts",
      "openssh-client",
      "ruby",
      "ruby-io-console",
      "ruby-irb",
      "ruby-rdoc",
      ["docker-api",              nil, "gem"],
      ["rspec",                   nil, "gem"],
      ["specinfra",               nil, "gem"],
      ["serverspec",              ENV["DOCKER_IMAGE_TAG"], "gem"],
    ]

    packages.each do |package, version, installer|
      describe package(package) do
        it { is_expected.to be_installed }                        if installer.nil? && version.nil?
        it { is_expected.to be_installed.with_version(version) }  if installer.nil? && ! version.nil?
        it { is_expected.to be_installed.by(installer) }          if ! installer.nil? && version.nil?
        it { is_expected.to be_installed.by(installer).with_version(version) } if ! installer.nil? && ! version.nil?
      end
    end
  end

  ### COMMANDS #################################################################

  describe "Commands" do

    # [command, version, args]
    commands = [
      "/usr/bin/docker",
      "/usr/bin/docker-compose",
    ]

    commands.each do |command, version, args|
      describe "Command \"#{command}\"" do
        subject { file(command) }
        let(:version_regex) { /\W#{version}\W/ }
        let(:version_cmd) { "#{command} #{args.nil? ? "--version" : "#{args}"}" }
        it "should be installed#{version.nil? ? nil : " with version \"#{version}\""}" do
          expect(subject).to exist
          expect(subject).to be_executable
          expect(command(version_cmd).stdout).to match(version_regex) unless version.nil?
        end
      end
    end
  end

  ##############################################################################

end

################################################################################

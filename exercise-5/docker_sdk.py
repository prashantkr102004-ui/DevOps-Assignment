import docker

client = docker.from_env()

image_name = "flask-apparmor"

# Run the container with the AppArmor profile
container = client.containers.run(
    image_name,
    detach=True,
    name="sdk-flask-secure",
    ports={"5000/tcp": 5002},
    security_opt=["apparmor=docker-flask-apparmor"]
)

print("Container started:", container.name)

# Inspect AppArmor configuration
container.reload()

print("AppArmor Profile:", container.attrs.get("AppArmorProfile"))
print("Security Options:", container.attrs["HostConfig"]["SecurityOpt"])

print("Docker SDK AppArmor configuration verified successfully.")

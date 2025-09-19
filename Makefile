.PHONY: build

ide-setup:
	ln -s ./build/compile_commands.json # only avail after a build

clean:
	rm -rf ./install ./build
	
notice:
	@echo "\e[1;31m⚠ Source ~/.bashrc to reload ./install/local_setup.bash\e[0m"

# Build sandbox with symlinks so that re-build 
# is not required during edit.
dev: clean
	colcon build --packages-select sandbox --symlink-install \
	&& $(MAKE) notice

# Build python + cpp
build: clean
	@{ \
	colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
	&& $(MAKE) notice \
	; }

# Build one python only
build-one:
	colcon build --packages-select sandbox \
	&& $(MAKE) notice

# Create a python package
pkg?=
create-python:
	@{ \
	cd src \
	&& ros2 pkg create $(pkg) \
		--build-type ament_python \
		--dependencies rclpy \
	&& echo "Created src/${pkg}" \
	&& tree ${pkg} \
	; }

.PHONY: build

clean:
	rm -rf ./install ./build

build: clean
	colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
	&& echo "re-source local-setup required" 

# Build with symlinks so that re-build is not required
dev:
	colcon build --packages-select pypkg --symlink-install \
	&& echo "re-source local-setup required" 

#
# python
#
py-build:
	colcon build --packages-select pypkg \
	&& echo "re-source local-setup required" 

py1:
	ros2 run pypkg node1
py2:
	ros2 run pypkg node2
pypub:
	ros2 run pypkg news_pub
pysub:
	ros2 run pypkg news_sub

# 
# C++
#
cpp1:
	ros2 run cpppkg node1

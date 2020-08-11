DIR=libraries

cd ..
if [ ! -d "$DIR" ]; then
        mkdir libraries
fi

EIGEN_PATH=http://bitbucket.org/eigen/eigen/get/3.3.7.tar.gz

wget -O eigen.tar.gz $EIGEN_PATH
mkdir libraries/eigen
tar -xzf eigen.tar.gz -C libraries/eigen --strip-components 1
rm eigen.tar.gz

BULLET_PATH=https://github.com/bulletphysics/bullet3/archive/2.88.tar.gz

wget -O bullet.tar.gz $BULLET_PATH
mkdir libraries/bullet3
tar -xzf bullet.tar.gz -C libraries/bullet3 --strip-components 1

rm bullet.tar.gz

cd install

patch ../libraries/bullet3/build_cmake_pybullet_double.sh  < bullet3.patch

cd ../libraries/bullet3

./build_cmake_pybullet_double.sh

cd ../../install

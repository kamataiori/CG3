#pragma once

//Vector3
struct Vector3 final {
	float x;
	float y;
	float z;

	Vector3 operator+(const Vector3& other) const { return { x + other.x, y + other.y, z + other.z }; }

	Vector3 operator-(const Vector3& other) const { return { x - other.x, y - other.y, z - other.z }; }

	Vector3 operator*(const float other) const { return { x * other, y * other, z * other }; }

	Vector3 operator/(const float other) const { return { x / other, y / other, z / other }; }

	Vector3 operator+=(const Vector3& other) {
		x += other.x;
		y += other.y;
		z += other.z;

		return *this;
	}
};

import pytest

def multiply(a, b):
    """
      Multiplica dos números.
    """
    return a * b

def test_multiply():
    assert multiply(2, 3) == 6
    assert multiply(-1, 1) == -1
    assert multiply(0, 5) == 0
    assert multiply(-5, -5) == 25
    assert multiply(2.5, 4) == 10.0

def test_multiply_fail():
    assert multiply(2, 2) == 5  # This test is expected to fail
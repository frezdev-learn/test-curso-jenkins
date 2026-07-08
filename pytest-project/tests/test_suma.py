import pytest

def suma(a, b):
    """
      Suma dos números.
    """
    return a + b

def test_suma():
    assert suma(2, 3) == 5
    assert suma(-1, 1) == 0
    assert suma(0, 0) == 0
    assert suma(-5, -5) == -10
    assert suma(2.5, 3.5) == 6.0

def test_suma_fail():
    assert suma(2, 2) == 5  # This test is expected to fail
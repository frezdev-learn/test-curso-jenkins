package com.miempresa;

import org.junit.Test;
import static org.junit.Assert.*;
import junit.framework.TestCase;

/**
 * Unit test for simple App.
 */
public class AppTest extends TestCase
{
    @Test
    public void testSuma() {
        App app = new App();
        int resultado = app.suma(2, 3);
        assertEquals(5, resultado);
    }
}

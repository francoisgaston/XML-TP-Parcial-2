<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:param name ="qty"/>
            
    <!-- Aplicamos los templates a los nodos flight -->
    <xsl:template match="/">
        <xsl:apply-templates select="//flight"/>
    </xsl:template>
    <!-- Iniciamos el filtrado de información -->
    <!-- Recorro todos los vuelos teniendo en cuenta que se puede o no tener un máximo -->
    <xsl:template match="//flight" name="Flights">
        <!-- -->
        <xsl:for-each select=".">
            <xsl:value-of select="./@id"/>,
            <xsl:value-of select="./country"/>,
            <xsl:value-of select="./position/lat"/>,
            <xsl:value-of select="./position/lng"/>,
            <xsl:value-of select="./departure_airport/country"/>,
            <xsl:value-of select="./departure_airport/name"/>,
            <xsl:value-of select="./arrival_airport/country"/>,
            <xsl:value-of select="./arrival_airport/country"/>,
        </xsl:for-each> 
    </xsl:template>


</xsl:stylesheet>
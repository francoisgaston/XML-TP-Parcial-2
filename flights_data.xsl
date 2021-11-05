<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" version="1.0" encoding="UTF-8" omit-xml-declaration="yes"/> 
    <xsl:param name="qty" select="count(.//flight)"/>
            
    <!-- Aplicamos los templates a los nodos flight -->
    <xsl:template match="/">
        \documentclass{article}
        \usepackage[a4paper,
                    left=1cm,
                    right=1cm,
                    top=2.5cm,
                    bottom=2.5cm]{geometry}

        \begin{document}
        \begin{titlepage}
            \begin{center}
                \vspace*{1cm}
                \Huge
                \textbf{Flight Report}
                    
                \vspace{0.75cm}
                \LARGE
                \textbf{XML Group XX}
                    
                \vspace{0.5cm}
                \LARGE
                \textsl{\today}
            \end{center}
        \end{titlepage}

        \newpage
        
        \begin{center}
            \begin{table}[]
            \centering
                \begin{tabular}{|p{1.5cm}|p{2cm}|p{4cm}|p{1.5cm}|p{3cm}|p{2.5cm}|}
                \hline
                Flight ID <xsl:text disable-output-escaping="yes">&amp;</xsl:text> Country      <xsl:text disable-output-escaping="yes">&amp;</xsl:text> Position                 <xsl:text disable-output-escaping="yes">&amp;</xsl:text> Status   <xsl:text disable-output-escaping="yes">&amp;</xsl:text> Departure Airport               <xsl:text disable-output-escaping="yes">&amp;</xsl:text> Arrival Airport                 \\ \hline \hline
                    <xsl:apply-templates select="//flight[position() &lt;= $qty]"/>
                \hline
                \end{tabular}
            \end{table}
        \end{center}
        \end{document}
    </xsl:template>
    <!-- Iniciamos el filtrado de información -->
    <!-- Recorro todos los vuelos teniendo en cuenta que se puede o no tener un máximo -->
    <xsl:template match="//flight" name="Flights">
        <xsl:for-each select=".">
            <xsl:value-of select="./@id"/> <xsl:text disable-output-escaping="yes">&amp;</xsl:text> 
            <xsl:value-of select="./country"/> <xsl:text disable-output-escaping="yes">&amp;</xsl:text> 
            <xsl:value-of select="./position/lat"/> <xsl:text disable-output-escaping="yes">&amp;</xsl:text> 
            <xsl:value-of select="./position/lng"/> <xsl:text disable-output-escaping="yes">&amp;</xsl:text> 
            <xsl:value-of select="./departure_airport/name"/> <xsl:text disable-output-escaping="yes">&amp;</xsl:text> 
            <xsl:value-of select="./arrival_airport/name"/> <xsl:text disable-output-escaping="yes">&amp;</xsl:text> 
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
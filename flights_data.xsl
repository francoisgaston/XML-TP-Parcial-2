<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" version="1.0" encoding="UTF-8" omit-xml-declaration="yes"/> 
    <xsl:param name="qty" select="-1"/>
    <xsl:template match="/">
    \documentclass{article}
    \usepackage{longtable}
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
                \textbf{XML Group 04}
                    
                \vspace{0.5cm}
                \LARGE
                \textsl{\today}
            \end{center}
        \end{titlepage}

        \newpage
        <xsl:if test="count(//flight) &gt; 0 ">
            <xsl:call-template name="Flights"/>
        </xsl:if>
        <xsl:apply-templates select="//error"/>
        \end{document}
    </xsl:template>

    <xsl:template name="Flights">
        \begin{longtable}{|p{1.5cm}|p{2cm}|p{4cm}|p{1.5cm}|p{3cm}|p{2.5cm}|}
            \hline
            Flight ID <xsl:text disable-output-escaping="yes">&amp;</xsl:text> Country      <xsl:text disable-output-escaping="yes">&amp;</xsl:text> Position                 <xsl:text disable-output-escaping="yes">&amp;</xsl:text> Status   <xsl:text disable-output-escaping="yes">&amp;</xsl:text> Departure Airport               <xsl:text disable-output-escaping="yes">&amp;</xsl:text> Arrival Airport \\ \hline \hline
            \endhead
            \hline
            \endfoot
            <xsl:if test="$qty &gt; -1">
                <xsl:apply-templates select="//flight[position() &lt;= $qty]"/>
            </xsl:if>
            <xsl:if test="$qty &lt;= -1">
                <xsl:apply-templates select="//flight"/>
            </xsl:if>
            \hline
        \end{longtable}
    </xsl:template>

    <xsl:template match="//flight" name="Flight">
        <xsl:for-each select=".">
            <xsl:value-of select="./@id"/> <xsl:text disable-output-escaping="yes">&amp;</xsl:text> 
            <xsl:value-of select="./country"/> <xsl:text disable-output-escaping="yes">&amp;</xsl:text> (<xsl:value-of select="./position/lat"/> , <xsl:value-of select="./position/lng"/> <xsl:text disable-output-escaping="yes"> ) &amp;</xsl:text>
            <xsl:value-of select="./status"/> <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
            <xsl:value-of select="./departure_airport/name"/> <xsl:text disable-output-escaping="yes">&amp;</xsl:text> 
            <xsl:value-of select="./arrival_airport/name"/> \\
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="//error" name="catchErrors">
            \vspace{0.75cm}
            \LARGE
            \textbf{ERROR:}
            \vspace{0.5cm}
            \Large
            \textsl{<xsl:value-of select="."/>}
    </xsl:template>

</xsl:stylesheet>
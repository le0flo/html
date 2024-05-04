<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <title>Leonardo - Files pubblici</title>
                <style>
                    * {
                        margin: 0;
                        font-family: Tahoma, Verdana, Arial, sans-serif;
                        box-sizing: border-box;
                    }

                    a {
                        color: inherit;
                        text-decoration: inherit;
                    }

                    table {
                        min-height: 200px;
                        margin: 10px;
                        
                        background-color: #13101b;
                        color: white;
                        padding: 10px;
                        border-radius: 10px;
                    }

                    .filename {
                        height: 50px;
                        padding: 5px;

                        background-color: antiquewhite;
                        color: black;
                        border-radius: 10px;
                    }
                </style>
            </head>
            <body>
                <h3>Il fileshare di leonardo</h3>
                <table>
                    <tr>
                        <th>Nome</th>
                        <th>Dimensione</th>
                        <th>Data</th>
                    </tr>
                    <xsl:for-each select="list/*">
                        <xsl:sort select="@mtime" />
                        <xsl:variable name="name">
                                <xsl:value-of select="." />
                        </xsl:variable>
                        <xsl:variable name="size">
                            <xsl:if test="string-length(@size) &gt; 0">
                                <xsl:if test="number(@size) &gt; 0">
                                    <xsl:choose>
                                        <xsl:when test="round(@size div 1024) &lt; 1"><xsl:value-of select="@size" /> Bytes</xsl:when>
                                        <xsl:when test="round(@size div 1048576) &lt; 1"><xsl:value-of select="format-number((@size div 1024), '0.0')" /> Kb</xsl:when>
                                        <xsl:when test="round(@size div 1073741824) &lt; 1"><xsl:value-of select="format-number((@size div 1048576), '0.0')" /> Mb</xsl:when>
                                        <xsl:otherwise><xsl:value-of select="format-number((@size div 1073741824), '0.00')" /> Gb</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:if>
                            </xsl:if>
                        </xsl:variable>
                        <xsl:variable name="date">
                            <xsl:value-of select="substring(@mtime,9,2)" />-<xsl:value-of select="substring(@mtime,6,2)" />-<xsl:value-of select="substring(@mtime,1,4)" />
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="substring(@mtime,12,2)" />:<xsl:value-of select="substring(@mtime,15,2)" />:<xsl:value-of select="substring(@mtime,18,2)" />
                        </xsl:variable>
                        <tr>
                            <td class="filename">
                                <a href="{$name}">
                                    <xsl:value-of select="." />
                                </a>
                            </td>
                            <td align="right">
                                <xsl:value-of select="$size" />
                            </td>
                            <td>
                                <xsl:value-of select="$date" />
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
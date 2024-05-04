<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html lang="it">
            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>Leonardo - Finder</title>
                <style>
                    * {
                        margin: 0;
                        font-family: monospace;
                        box-sizing: border-box;
                    }

                    a {
                        color: inherit;
                    }

                    body {
                        width: 100vw;
                        height: 100vh;
                        
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }

                    .finestra {
                        width: fit-content;
                        min-height: 200px;
                        margin: 10px;

                        background-color: #13101b;
                        color: white;
                        padding: 10px;
                        padding-top: 30px;
                        border-radius: 10px;

                        position: relative;
                    }

                    table {
                        border-spacing: 5px;
                    }

                    th {
                        height: 30px;
                        padding: 10px;

                        background-color: rgba(120, 154, 130);
                        color: antiquewhite;
                        text-align: left;
                        border-radius: 10px;
                    }

                    td {
                        padding: 10px;

                        background-color: rgba(150, 150, 150, .5);
                        color: antiquewhite;
                        border-radius: 10px;
                    }

                    .filename {
                        height: 30px;
                        padding: 10px;

                        background-color: antiquewhite;
                        color: black;
                        border-radius: 10px;
                    }

                    .finestra > .button {
                        width: 10px;
                    
                        aspect-ratio: 1/1;
                        border-radius: 10px;
                    
                        position: absolute;
                        top: 10px;
                    }
                    
                    .finestra > .close {
                        background-color: #ff605c;
                        left: 10px;
                    }
                    
                    .finestra > .minimize {
                        background-color: #ffbd44;
                        left: 25px;
                    }
                    
                    .finestra > .maximize {
                        background-color: #00ca4e;
                        left: 40px;
                    }
                </style>
            </head>
            <body>
                <div class="finestra">
                    <a href="https://le0nardo.dev" class="button close"></a>
                    <a href="https://le0nardo.dev" class="button minimize"></a>
                    <a href="https://le0nardo.dev" class="button maximize"></a>

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
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
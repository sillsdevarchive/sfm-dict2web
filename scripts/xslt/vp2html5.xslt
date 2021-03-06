<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	  <xsl:preserve-space elements="*"/>
	  <xsl:output method="html" version="5.0" encoding="utf-8" omit-xml-declaration="yes" indent="no"/>
	  <xsl:param name="sourcetexturi"/>
	  <xsl:variable name="text0" select="replace(replace(unparsed-text($sourcetexturi),'(\r)',''),'&lt;(\d+)&gt;','&amp;#$1;')"/>
	  <!--  <xsl:variable name="text1">
		   <xsl:analyze-string select="unparsed-text($sourcetexturi)" regex="(.+)&lt;(\d+)&gt;(.+)">
				  <xsl:matching-substring>
						<xsl:value-of select="regex-group(1)"/>
						<xsl:text disable-output-escaping="yes">&amp;</xsl:text>
						<xsl:value-of select="regex-group(2)"/>
						<xsl:text>;</xsl:text>
						<xsl:value-of select="regex-group(3)"/>
				  </xsl:matching-substring>
			</xsl:analyze-string>
	  </xsl:variable> -->
	  <xsl:variable name="text2" select="replace(replace($text0,'&lt;&lt;','&#8220;'),'&gt;&gt;','&#8221;')"/>
	  <xsl:variable name="text3" select="replace($text2,'\n','')"/>
	  <xsl:variable name="punctuation" select="',.?!'"/>
	  <xsl:template match="/">
			<html lang="en">
				  <xsl:call-template name="head"/>
				  <xsl:element name="body">
						<xsl:analyze-string select="$text2" regex="@LEMMA = ">
							  <!-- split on backslash, add a space to the end of every line so every empty sfm can be found -->
							  <xsl:matching-substring/>
							  <xsl:non-matching-substring>
									<xsl:variable name="lemma" select="substring-before(.,'@')"/>
									<xsl:variable name="poststring" select="substring-after(.,'@')"/>
									<xsl:if test="string-length($lemma) gt 0">
										  <xsl:element name="div">
												<xsl:attribute name="class">
													  <xsl:text>lxGroup</xsl:text>
												</xsl:attribute>
												<span class="lx">
													  <xsl:value-of select="replace($lemma,'\n','')"/>
												</span>
												<xsl:call-template name="parsedivs">
													  <xsl:with-param name="string" select="$poststring"/>
												</xsl:call-template>
										  </xsl:element>
										  <xsl:text>

</xsl:text>
									</xsl:if>
							  </xsl:non-matching-substring>
						</xsl:analyze-string>
				  </xsl:element>
			</html>
	  </xsl:template>
	  <xsl:template name="parsedivs">
			<!-- analyze-string template -->
			<xsl:param name="string"/>
			<xsl:analyze-string select="$string" regex="\n@">
				  <xsl:matching-substring/>
				  <xsl:non-matching-substring>
						<xsl:call-template name="parsediv">
							  <xsl:with-param name="string" select="."/>
						</xsl:call-template>
				  </xsl:non-matching-substring>
			</xsl:analyze-string>
	  </xsl:template>
	  <xsl:template name="parsediv">
			<!-- analyze-string template -->
			<xsl:param name="string"/>
			<xsl:variable name="divclass" select="replace(substring-before($string,' = '),' ','_')"/>
			<xsl:variable name="data" select="substring-after($string,' = ')"/>
			<xsl:text>
</xsl:text>
			<xsl:choose>
				  <xsl:when test="substring-before($divclass,'_') = 'TABLE'">
						<xsl:choose>
							  <xsl:when test="$divclass = 'TABLE_HEADING'">
									<div class="{$divclass}">
										  <xsl:call-template name="parsedivstring">
												<xsl:with-param name="string" select="$data"/>
										  </xsl:call-template>
									</div>
							  </xsl:when>
							  <xsl:otherwise>
									<table class="{$divclass}">
										  <xsl:call-template name="parsetablelines">
												<xsl:with-param name="string" select="$data"/>
										  </xsl:call-template>
									</table>
							  </xsl:otherwise>
						</xsl:choose>
				  </xsl:when>
				  <xsl:otherwise>
						<div class="{$divclass}">
							  <xsl:call-template name="parsedivstring">
									<xsl:with-param name="string" select="$data"/>
							  </xsl:call-template>
						</div>
				  </xsl:otherwise>
			</xsl:choose>
	  </xsl:template>
	  <xsl:template name="parsedivstring">
			<!-- analyze-string template -->
			<xsl:param name="string"/>
			<xsl:analyze-string select="$string" regex="&lt;">
				  <xsl:matching-substring/>
				  <xsl:non-matching-substring>
						<xsl:call-template name="parsetagndata">
							  <xsl:with-param name="string" select="."/>
						</xsl:call-template>
				  </xsl:non-matching-substring>
			</xsl:analyze-string>
	  </xsl:template>
	  <xsl:template name="parsetagndata">
			<xsl:param name="string"/>
			<xsl:analyze-string select="replace($string,'\n','')" regex="(.+)&gt;(.*)" flags="m">
				  <xsl:matching-substring>
						<xsl:if test="string-length(regex-group(2)) gt 0">
							  <xsl:element name="span">
									<xsl:attribute name="class">
										  <xsl:value-of select="regex-group(1)"/>
									</xsl:attribute>
									<!-- insert space before if not punctuation -->
									<xsl:choose>
										  <xsl:when test="substring(regex-group(2),1,1) = ','
or substring(regex-group(2),1,1) = '.'
or substring(regex-group(2),1,1) = '?'
or substring(regex-group(2),1,1) = '!'
or substring(regex-group(2),1,1) = ';'
or substring(regex-group(2),1,1) = ')'
"/>
										  <xsl:otherwise>
												<xsl:text> </xsl:text>
										  </xsl:otherwise>
									</xsl:choose>
									<xsl:value-of select="normalize-space(regex-group(2))"/>
							  </xsl:element>
						</xsl:if>
				  </xsl:matching-substring>
			</xsl:analyze-string>
	  </xsl:template>
	  <xsl:template name="head">
			<head>
				  <STYLE type="text/css">
							 .lx {font-size: 120%}
							 .ENTRY_BODY {display:inline;}
							 .ENTRY_BODY:before {content:' '}
.M:after {content:' '}
.MI:after {content:' '}
.B {font-weight:bold}
							</STYLE>
			</head>
	  </xsl:template>
	  <xsl:template name="parsetablelines">
			<!-- analyze-string template -->
			<xsl:param name="string"/>
			<xsl:analyze-string select="$string" regex="\n">
				  <xsl:matching-substring/>
				  <xsl:non-matching-substring>
						<tr>
							  <xsl:call-template name="parsetablecells">
									<xsl:with-param name="string" select="."/>
							  </xsl:call-template>
						</tr>
				  </xsl:non-matching-substring>
			</xsl:analyze-string>
	  </xsl:template>
	  <xsl:template name="parsetablecells">
			<!-- analyze-string template -->
			<xsl:param name="string"/>
			<xsl:analyze-string select="$string" regex="\t">
				  <xsl:matching-substring/>
				  <xsl:non-matching-substring>
						<td>
							  <xsl:choose>
									<xsl:when test="matches(.,'&lt;')">
<xsl:if  test="string-length(substring-before(.,'&lt;')) gt 0">
 <xsl:value-of select="substring-before(.,'&lt;')"/>
</xsl:if>
										  <xsl:call-template name="parsedivstring">
												<xsl:with-param name="string" select="."/>
										  </xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										  <xsl:value-of select="."/>
									</xsl:otherwise>
							  </xsl:choose>
						</td>
				  </xsl:non-matching-substring>
			</xsl:analyze-string>
	  </xsl:template>
</xsl:stylesheet>

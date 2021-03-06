<?xml version="1.0"?>

<xsl:stylesheet version="2.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:silp="http://silp.org.ph/ns" exclude-result-prefixes="silp">
	  <xsl:template name="navigation">
			<xsl:param name="rec"/>
			<xsl:param name="class"/>
			<xsl:element name="div">
				  <xsl:attribute name="class">
						<xsl:value-of select="$class"/>
				  </xsl:attribute>
				  <xsl:element name="a">
						<xsl:attribute name="href">
							  <xsl:value-of select="silp:first($rec)"/>
						</xsl:attribute>
						<xsl:if test="$target != ''">
							  <xsl:attribute name="target">
									<xsl:value-of select="$target"/>
							  </xsl:attribute>
						</xsl:if>
						<xsl:text>|&lt;&#160; First</xsl:text>
				  </xsl:element>
				  <xsl:element name="a">
						<xsl:attribute name="href">
							  <xsl:value-of select="silp:prev($rec)"/>
						</xsl:attribute>
						<xsl:if test="$target != ''">
							  <xsl:attribute name="target">
									<xsl:value-of select="$target"/>
							  </xsl:attribute>
						</xsl:if>
						<xsl:text>&lt;&#160;Previous</xsl:text>
				  </xsl:element>
				  <xsl:element name="a">
						<xsl:attribute name="href">
							  <xsl:value-of select="silp:next($rec)"/>
						</xsl:attribute>
						<xsl:if test="$target != ''">
							  <xsl:attribute name="target">
									<xsl:value-of select="$target"/>
							  </xsl:attribute>
						</xsl:if>
						<xsl:text>Next&#160;&gt;</xsl:text>
				  </xsl:element>
				  <xsl:element name="a">
						<xsl:attribute name="href">
							  <xsl:value-of select="silp:last($rec)"/>
						</xsl:attribute>
						<xsl:if test="$target != ''">
							  <xsl:attribute name="target">
									<xsl:value-of select="$target"/>
							  </xsl:attribute>
						</xsl:if>
						<xsl:text>Last&#160;&gt;|</xsl:text>
				  </xsl:element>
			</xsl:element>
	  </xsl:template>
</xsl:stylesheet>

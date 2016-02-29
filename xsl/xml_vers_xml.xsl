<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	
	<xsl:output method="xml" indent="yes" />

	<xsl:template match="/">
		<master>
			<xsl:call-template name="parcours"/>
			<xsl:call-template name="intervenants"/>
		</master>
	</xsl:template>
	
	<xsl:template name="parcours">
		<xsl:for-each select="//objet[@type = 'programme']">
			<xsl:variable name="idParcours" select="@id"/>
			<parcours>
				<xsl:attribute name="id"><xsl:value-of select="$idParcours"/></xsl:attribute>
				
				<nom><xsl:value-of select="info[@nom='nom']/@value"/></nom>

				<ref-intervenant>
					<xsl:attribute name="ref">
						<xsl:variable name="idIntervenant" select="info[@nom='responsable-rof']/@value"/>					
						
						<xsl:for-each select="//objet[@type = 'personne']">
							<xsl:variable name="idInter" select="@id"/>
						
							<xsl:if test="$idIntervenant=$idInter">
								<xsl:value-of select="info[@nom='nom']/@value"/>
							</xsl:if>
							
						</xsl:for-each>
						
					</xsl:attribute>
				</ref-intervenant> 
				
				<description><xsl:value-of select="info[@nom='aspects_format_recherche']/*"/></description>
				
				
				<xsl:call-template name="semestres"/>
<!-- 
				inclure les unites dans le semestre
				ici pour le moment car long a compiler sinon
-->
				<xsl:call-template name="unites"/>
				
				<debouche><xsl:value-of select="info[@nom='aspects_format_recherche']/*"/></debouche>
			
			</parcours>
		</xsl:for-each>
	</xsl:template>
   
	<xsl:template name="semestres">
		<xsl:for-each select="//objet[@type = 'semestre']">
			<xsl:variable name="idSemestre" select="@id"/>
		<!-- <xsl:variable name="idSemestre" select="info[@nom='numero']/@value"/> -->
			<semestre>
				<xsl:attribute name="id">
					<xsl:value-of select="$idSemestre"/>
				</xsl:attribute>
				
<!--
				<xsl:for-each select="//objet[@nom = 'structure']">
				</xsl:for-each>
-->
<!--
				commentaire tmp
-->
<!--
				<xsl:call-template name="unites"/>
-->
			</semestre>
		</xsl:for-each>
   
   </xsl:template>
   
	<xsl:template name="unites">
		<xsl:for-each select="//objet[@type = 'enseignement']">
			<xsl:variable name="idUnite" select="@id"/>
			<unite>
				<xsl:attribute name="id">
					<xsl:value-of select="$idUnite"/>
				</xsl:attribute>
				<nom><xsl:value-of select="info[@nom='nom']/@value"/></nom>

				<xsl:for-each select="info[@nom='responsables']">
					<xsl:variable name="idIntervenant" select="@value"/>
						
						<ref-intervenant>
							<xsl:attribute name="ref">
								<xsl:for-each select="//objet[@type = 'personne']">
									<xsl:variable name="idInter" select="@id"/>
								
									<xsl:if test="$idIntervenant=$idInter">
										<xsl:value-of select="info[@nom='nom']/@value"/>
									</xsl:if>
									
								</xsl:for-each>
								
							</xsl:attribute>
						</ref-intervenant>
			
				</xsl:for-each>
		
				<credits><xsl:value-of select="info[@nom='nb_credits']/@value"/></credits>
				<resume><xsl:copy-of select="info[@nom='contenu']/*"/></resume>
				<plan>Cours/TD/TP : <xsl:value-of select="info[@nom='vol_cm']/@value"/>h/<xsl:value-of select="info[@nom='vol_td']/@value"/>h/<xsl:value-of select="info[@nom='vol_tp']/@value"/>h</plan>
<!-- Pas de lieu donc mettre dans la dtd en optionnel OU rajouter-->
			</unite>
		</xsl:for-each>
	</xsl:template>
   
	<xsl:template name="intervenants">
		<xsl:for-each select="//objet[@type = 'personne']">
			<xsl:variable name="idIntervenant" select="@id"/>
			<intervenant>
				<xsl:attribute name="id">
					<xsl:value-of select="$idIntervenant"/>
				</xsl:attribute>
<!-- Mettre un espace entre le prenom et le nom-->
				<nom><xsl:value-of select="info[@nom='prenom']/@value"/><xsl:value-of select="info[@nom='nom']/@value"/></nom>
				<mail><xsl:value-of select="info[@nom='nom']/@value"/></mail>
<!-- Pas de lieu donc mettre dans la dtd en optionnel OU rajouter-->
			</intervenant>
		</xsl:for-each>
	</xsl:template>
   
   
   
</xsl:stylesheet>


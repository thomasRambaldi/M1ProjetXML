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
				
				
<!--
				<xsl:call-template name="semestres"/>
-->
				<xsl:call-template name="semestre"/>
				
				<debouche><xsl:value-of select="info[@nom='aspects_format_recherche']/*"/></debouche>
			
			</parcours>
		</xsl:for-each>
	</xsl:template>
   
	<xsl:template name="semestre">
		<xsl:for-each select="info[@nom='structure']">
			<xsl:variable name="idSemestre" select="@value"/>
				
				<!-- parcours de tous les semestre-->
				<xsl:for-each select="//objet[@type = 'semestre']">
					<xsl:variable name="idSemes" select="@id"/>
					<xsl:variable name="numeroSemestre" select="info[@nom='numero']/@value"/>
		
					<!-- Test de l'existance d'un semestre -->
					<xsl:if test="$idSemestre=$idSemes">
						<semestre>
							<xsl:attribute name="id">
								<xsl:value-of select="$numeroSemestre"/>
							</xsl:attribute>
							
							<xsl:call-template name="blocUnite"/>
							
						</semestre>
					</xsl:if>
				</xsl:for-each>
		</xsl:for-each>
   
   </xsl:template>
   
   
   
      
	<xsl:template name="blocUnite">
		<xsl:for-each select="info[@nom='structure']">
			<xsl:variable name="idUnite" select="@value"/>

			<!-- Bloc d'unite d'option-->
			<xsl:for-each select="//objet[@type = 'option']">
				<xsl:variable name="idOption" select="@id"/>

				<xsl:if test="$idUnite=$idOption">
					
					<xsl:variable name="idUEOption" select="info[@nom='structure']/@value"/>
					
						
					<xsl:for-each select="//objet[@type = 'enseignement']">
						<xsl:variable name="idUEOpt" select="@id"/>
					
						<xsl:if test="$idUEOption=$idUEOpt">
						<unite>
							<xsl:attribute name="id">
								<xsl:value-of select="$idUEOpt"/>
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

							<nbCredits><xsl:value-of select="info[@nom='nb_credits']/@value"/></nbCredits>
							<resume><xsl:copy-of select="info[@nom='contenu']/*"/></resume>
							<plan>Cours/TD/TP : <xsl:value-of select="info[@nom='vol_cm']/@value"/>h/<xsl:value-of select="info[@nom='vol_td']/@value"/>h/<xsl:value-of select="info[@nom='vol_tp']/@value"/>h</plan>
						</unite>
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
			</xsl:for-each>

			<!-- Bloc d'unite de groupe-->
			<xsl:for-each select="//objet[@type = 'groupe']">
				<xsl:variable name="idGroupe" select="@id"/>

				<xsl:if test="$idUnite=$idGroupe">
					
					<xsl:variable name="idUEGroupe" select="info[@nom='structure']/@value"/>
					
						
					<xsl:for-each select="//objet[@type = 'enseignement']">
						<xsl:variable name="idUEGr" select="@id"/>
					
						<xsl:if test="$idUEGroupe=$idUEGr">
						<unite>
							<xsl:attribute name="id">
								<xsl:value-of select="$idUEGr"/>
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

							<nbCredits><xsl:value-of select="info[@nom='nb_credits']/@value"/></nbCredits>
							<resume><xsl:copy-of select="info[@nom='contenu']/*"/></resume>
							<plan>Cours/TD/TP : <xsl:value-of select="info[@nom='vol_cm']/@value"/>h/<xsl:value-of select="info[@nom='vol_td']/@value"/>h/<xsl:value-of select="info[@nom='vol_tp']/@value"/>h</plan>
						</unite>
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
			</xsl:for-each>

			<!-- Unite simple-->
			<xsl:for-each select="//objet[@type = 'enseignement']">
				<xsl:variable name="idUnit" select="@id"/>
					<xsl:if test="$idUnite=$idUnit">
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
					
							<nbCredits><xsl:value-of select="info[@nom='nb_credits']/@value"/></nbCredits>
							<resume><xsl:copy-of select="info[@nom='contenu']/*"/></resume>
							<plan>Cours/TD/TP : <xsl:value-of select="info[@nom='vol_cm']/@value"/>h/<xsl:value-of select="info[@nom='vol_td']/@value"/>h/<xsl:value-of select="info[@nom='vol_tp']/@value"/>h</plan>
						</unite>
					</xsl:if>
				</xsl:for-each>
				
		</xsl:for-each>
	</xsl:template>
	
	
		<xsl:template name="intervenants">
		<xsl:for-each select="//objet[@type = 'personne']">
			<xsl:variable name="idIntervenant" select="@id"/>
			<xsl:variable name="nomIntervenant" select="info[@nom='nom']/@value"/>
			<intervenant>
				<xsl:attribute name="id">
					<xsl:value-of select="$nomIntervenant"/>
				</xsl:attribute>
<!-- Mettre un espace entre le prenom et le nom-->
				<nom><xsl:value-of select="info[@nom='prenom']/@value"/><xsl:value-of select="info[@nom='nom']/@value"/></nom>
				<mail>
					<xsl:value-of select="info[@nom='prenom']/@value"/>.
					<xsl:value-of select="info[@nom='nom']/@value"/>@univ-amu.fr
				</mail>
<!-- Pas de lieu donc mettre dans la dtd en optionnel OU rajouter-->
			</intervenant>
		</xsl:for-each>
	</xsl:template>
	
<!--
	Ce template est inutile
-->
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
		
				<nbCredits><xsl:value-of select="info[@nom='nb_credits']/@value"/></nbCredits>
				<resume><xsl:copy-of select="info[@nom='contenu']/*"/></resume>
				<plan>Cours/TD/TP : <xsl:value-of select="info[@nom='vol_cm']/@value"/>h/<xsl:value-of select="info[@nom='vol_td']/@value"/>h/<xsl:value-of select="info[@nom='vol_tp']/@value"/>h</plan>
<!-- Pas de lieu donc mettre dans la dtd en optionnel OU rajouter-->
			</unite>
		</xsl:for-each>
	</xsl:template>
   
 
</xsl:stylesheet>



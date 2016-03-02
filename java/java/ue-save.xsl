<?xml version="1.0" encoding="utf-8" ?>
<!--
Reste à faire :  
	- Lister les données
	- Lier les données
	- ...
-->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

	<xsl:output method="html" encoding="utf-8"/>

<!--
Branche principal master
-->
	<xsl:template match="master">
		<html>
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				<title>Projet</title>
				<xsl:call-template name="liste_des_intervenants"/>
				<xsl:call-template name="liste_des_unites"/>
				<h3>Détails des intervenants : </h3>
				<xsl:apply-templates select="intervenant"/>
				<h3>Détails des unités : </h3>
				<xsl:call-template name="details_unites"/>
			</head>
			
			<xsl:document href="index.html">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
						<title>Index</title>
					</head>
					<body>
						<h1>Les masters de Luminy</h1>
						<xsl:call-template name="liste_des_intervenants"/>
						<xsl:call-template name="liste_des_unites"/>
					</body>
				</html>
			</xsl:document>
			
			<xsl:document href="intervenants.html">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
						<title>Intervenants</title>
						
					</head>
					<body>
						<h2>Liste des intervenants : </h2>
						<xsl:call-template name="intervenants"/>
					</body>
				</html>
			</xsl:document>
						
			<xsl:document href="unites.html">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
						<title>Unites</title>
					</head>
					<body>
						<h2>Liste des unités : </h2>
						<xsl:call-template name="details_unites"/>
					</body>
				</html>
			</xsl:document>

<!--
Crée une page par unité
-->
			<xsl:for-each select="parcours/semestre/unite">
				<xsl:variable name="id" select="parcours/semestre/unite"/>
				<xsl:document href="unites-{@id}.html">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
						<title><xsl:value-of select="nom"/></title>
					</head>
					<body>
						<h2>Unite : <xsl:value-of select="nom"/></h2>
						<xsl:call-template name="details_unite"/>
					</body>
				</html>
				</xsl:document>
			</xsl:for-each>
			
<!--
Crée une page par intervenant
-->
			<xsl:for-each select="intervenant">
				<xsl:variable name="id" select="intervenant"/>
				<xsl:document href="intervenant-{@id}.html">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
						<title><xsl:value-of select="nom"/></title>
					</head>
					<body>
						<h2>Intervenant : <xsl:value-of select="nom"/></h2>
						<xsl:call-template name="intervenant"/>
					</body>
				</html>
				</xsl:document>
			</xsl:for-each>
			
			
			<xsl:for-each select="parcours">
				<xsl:variable name="id" select="parcours"/>
				<xsl:document href="parcours-{@id}.html">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
						<title><xsl:value-of select="nom"/></title>
					</head>
					<body>
						<xsl:call-template name="parcours"/>
					</body>
				</html>
				</xsl:document>
			</xsl:for-each>

		</html>
	</xsl:template>

<!--
Liste tous les intervenants
-->
<xsl:template name="liste_des_intervenants">
	<h3>
		Liste des intervenants : 
		<xsl:for-each select="intervenant">
			<xsl:variable name="id" select="intervenant"/>
			<ul>
				<li><a href="intervenant-{@id}.html"><xsl:value-of select="nom"/></a></li>
			</ul>
		</xsl:for-each>
	</h3>
</xsl:template>

<!--
Liste de tous les unités
-->
<xsl:template name="liste_des_unites">
	<h3>
		Liste des unités : 
		<xsl:for-each select="parcours/semestre/unite">
			<xsl:variable name="id" select="parcours/semestre/unite"/>
			<ul>
				<li><a href="unites-{@id}.html"><xsl:value-of select="nom"/></a></li>
			</ul>
		</xsl:for-each>
	</h3>
</xsl:template>

<!--
Liste les intervenants avec les détails de ces dernier
-->
<xsl:template name="intervenants">
	<xsl:for-each select="intervenant">
		<xsl:call-template name="intervenant"/>
	</xsl:for-each>
</xsl:template>

<xsl:template name="intervenant">
	<xsl:element name="ul">
		<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
		<li>id : <xsl:value-of select="@id"/></li>
		<li>nom : <xsl:value-of select="nom"/></li>
		<li>Email : <xsl:value-of select="mail"/></li>
		<li>Lien : <xsl:element name="a">
					<xsl:attribute name="href"><xsl:value-of select="web"/></xsl:attribute>
					<xsl:value-of select="web"/>
				</xsl:element></li>

	</xsl:element>
</xsl:template>

<!--
Liste toutes les unités ainsi que leurs détails
-->
<xsl:template name="details_unites">
	<xsl:for-each select="parcours/semestre/unite">
		<xsl:call-template name="details_unite"/>
	</xsl:for-each>
</xsl:template>

<!--
Détail d'une unité
-->
<xsl:template name="details_unite">
	
		<xsl:variable name="id" select="parcours/semestre/unite"/>
		<h4 id="{@id}">
			Unité : <xsl:value-of select="unite"/>
			<xsl:apply-templates select="nom"/>
		</h4>
		<p>
			id : <xsl:value-of select="@id"/><br/>
			unité : <xsl:value-of select="@role"/><br/>
			<xsl:if test="ref-intervenant">
				Responsable(s) : <xsl:apply-templates select="ref-intervenant"/>
			</xsl:if>
			Credits : <xsl:apply-templates select="nbCredits"/><br/>
			Résume : <br/><xsl:apply-templates select="resume"/><br/>
			Plan : <xsl:apply-templates select="plan"/><br/>
			Lieu : <xsl:apply-templates select="lieu"/>
		</p>
</xsl:template>

<xsl:template match="ref-intervenant">
	<ul>
		<li><a href="intervenant-{@ref}.html"><xsl:value-of select="@ref"/></a></li>
	</ul>
</xsl:template>

	
<!--
Liste tous les parcours avec les détails de ces dernier
-->	

<xsl:template name="parcours">
	<h2>Parcours : <xsl:value-of select="nom"/></h2>
	<h3>Responsable(s) : </h3> <xsl:call-template name="intervenants"/>
	<xsl:call-template name="description"/>

	<xsl:call-template name="semestre"/>
	<!--
	<xsl:call-template name="debouche"/>
-->
</xsl:template>

<xsl:template name="description">
	<p>
		<xsl:value-of select="description"/>
	</p>
</xsl:template>

<xsl:template name="semestre">
	<xsl:call-template name="details_unite"/>
</xsl:template>

<xsl:template name="debouche">
	<p>
		<xsl:value-of select="description"/>
	</p>
</xsl:template>





		

	


	
<!--
Liste tous les semestres ainsi que leurs détails
-->
	<xsl:template match="semestre">
		<h2>semestre : <xsl:value-of select="@numero"/></h2>
		<xsl:apply-templates select="unite"/>
		<xsl:apply-templates select="description"/>
		<xsl:apply-templates select="debouche"/>
		<xsl:apply-templates select="semestre"/>
	</xsl:template>
	


</xsl:stylesheet>

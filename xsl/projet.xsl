<?xml version="1.0" encoding="UTF-8" ?>

<!DOCTYPE stylesheet [
  <!ENTITY % w3centities-f PUBLIC "-//W3C//ENTITIES Combined Set//EN//XML"
      "http://www.w3.org/2003/entities/2007/w3centities-f.ent">
  %w3centities-f;
]>

<!--
A FAIRE : 
	- Étape 3 : Construire la liste des intervenants qui n'enseignent qu'à Luminy 
	(une seule expression XPATH).
	- Pour améliorer l'efficacité de vos transformations XSL, 
	utilisez la clause xsl:key afin de pouvoir retrouver facilement les UE à partir 
	des identifiants des intervenants.
	Profitez-en pour lister (avec la règle nommée précédente), les intervenants 
	qui s'occupent de trois UE.


-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

	<xsl:output method="html" encoding="utf-8"/>

	<xsl:key 
		name="ue_a_partir_intervenant"
		match="."
		use="@id"
	/>

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
			
			<xsl:document href="www/index.html">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
						<link rel="stylesheet" type="text/css" href="../css/css.css"/>
						<title>Index</title>
					</head>
					<body>
						<div class="index">
							<img src="../res/logo-sciences.png" alt="logo-sciences" />
	<!--
						a finir : test
	-->
	<!--
					 <xsl:call-template name="loop">
					  <xsl:with-param name="i" select="0"/>
					  <xsl:with-param name="limit" select="3"/>
					</xsl:call-template>
	-->

	<!--
							<xsl:for-each select="key('ue_a_partir_intervenant', 'morin')">
								<xsl:value-of select="($i)+1"/>
								<xsl:for-each select="//unite">
									
									<xsl:if test="">
										
									</xsl:if>
								</xsl:for-each>
								
							</xsl:for-each>
	-->
							
							
							<h5>
								<a href="index.html">Retour vers la page d'accueil</a> &nbsp;
								<a href="intervenants.html">Liste des intervenants</a> &nbsp;
								<a href="unites.html">Liste des unites</a>
							</h5>
							
							<h1>Les masters de Luminy</h1>
							<xsl:call-template name="liste_des_intervenants"/>
							<xsl:call-template name="liste_des_parcours"/>
							<xsl:call-template name="liste_des_unites"/>
							
							<div class="sous-titre-index">Liste des unités à 3 crédits se déroulant à Luminy : </div>
							
							<xsl:element name="ol">
								<xsl:for-each select="//unite">
										<xsl:call-template name="liste-des-UE-a-3-credits"/>
	<!--
											<xsl:with-param name="lieu" select="lieu" />
											<xsl:with-param name="nomUe" select="nom" />
											<xsl:with-param name="nbCredits" select="nbCredits" />
	-->
								</xsl:for-each>
							</xsl:element>
	<!--
						a finir
	-->
							<div class="sous-titre-index">Liste des intervenants enseignant qu'à Luminy : </div>
							<xsl:element name="ol">
								<xsl:for-each select="//unite">
									<xsl:call-template name="liste-des-intervenant-enseingant-luminy"/>
								</xsl:for-each>
							</xsl:element>
						</div>
					</body>
				</html>
			</xsl:document>
			
			<xsl:document href="www/intervenants.html">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
						<link rel="stylesheet" type="text/css" href="../css/css.css"/>
						<title>Intervenants</title>
					</head>
					<body>
						<div class="intervenants">
							<h5>
								<a href="index.html">Retour vers la page d'accueil</a> &nbsp;
								<a href="intervenants.html">Liste des intervenants</a> &nbsp;
								<a href="unites.html">Liste des unites</a>
							</h5>
							<h1>Liste des intervenants</h1>
							<xsl:call-template name="intervenants"/>
						</div>
					</body>
				</html>
			</xsl:document>
						
			<xsl:document href="www/unites.html">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

						<link rel="stylesheet" type="text/css" href="../css/css.css"/>
						<title>Unites</title>
					</head>
					<body>
						<div class="unites">
							<h5>
								<a href="index.html">Retour vers la page d'accueil</a> &nbsp;
								<a href="intervenants.html">Liste des intervenants</a> &nbsp;
								<a href="unites.html">Liste des unites</a>
							</h5>
							<h1>Liste des unités</h1>
							<xsl:call-template name="details_unites"/>
						</div>
					</body>
				</html>
			</xsl:document>

			<xsl:call-template name="page_par_unite"/>
			<xsl:call-template name="page_par_intervenant"/>
			<xsl:call-template name="page_par_parcours"/>

		</html>
	</xsl:template>


<!--
TEST
-->
 <xsl:template name="loop">
    <xsl:param name="i"/>
    <xsl:param name="limit"/>
    <xsl:if test="$i &lt; $limit">
      <div>
        <xsl:value-of select="$i"/>
      </div>
      <xsl:call-template name="loop">
        <xsl:with-param name="i" select="$i+1"/>
        <xsl:with-param name="limit" select="$limit"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
<!--
FIN TEST
-->


<!--
Crée une page par unité
-->
	<xsl:template name="page_par_unite">
			<xsl:for-each select="parcours/semestre/unite">
				<xsl:variable name="id" select="parcours/semestre/unite"/>
				<xsl:document href="www/unites-{@id}.html">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
						<title><xsl:value-of select="nom"/></title>
					</head>
					<body>
						<h5>
							<a href="index.html">Retour vers la page d'accueil</a> &nbsp;
							<a href="intervenants.html">Liste des intervenants</a> &nbsp;
							<a href="unites.html">Liste des unites</a>
						</h5>
						<h2>Unite : <xsl:value-of select="nom"/></h2>
						<xsl:call-template name="details_unite"/>
					</body>
				</html>
				</xsl:document>
			</xsl:for-each>
	</xsl:template>

<!--
Crée une page par intervenant
-->
	<xsl:template name="page_par_intervenant">
			<xsl:for-each select="intervenant">
				<xsl:variable name="id" select="intervenant"/>
				<xsl:document href="www/intervenant-{@id}.html">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
						<title><xsl:value-of select="nom"/></title>
					</head>
					<body>
						<h5>
							<a href="index.html">Retour vers la page d'accueil</a> &nbsp;
							<a href="intervenants.html">Liste des intervenants</a> &nbsp;
							<a href="unites.html">Liste des unites</a>
						</h5>
						<h2>Intervenant : <xsl:value-of select="nom"/></h2>
						<xsl:call-template name="intervenant"/>
					</body>
				</html>
				</xsl:document>
			</xsl:for-each>
	</xsl:template>
	
<!--
Crée une page par parcours
-->	
	<xsl:template name="page_par_parcours">
		<xsl:for-each select="parcours">
			<xsl:variable name="id" select="parcours"/>
			<xsl:document href="www/parcours-{@id}.html">
			<html>
				<head>
					<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
					<title><xsl:value-of select="nom"/></title>
				</head>
				<body>
						<h5>
							<a href="index.html">Retour vers la page d'accueil</a> &nbsp;
							<a href="intervenants.html">Liste des intervenants</a> &nbsp;
							<a href="unites.html">Liste des unites</a>
						</h5>
					<xsl:call-template name="parcours"/>
				</body>
			</html>
			</xsl:document>
		</xsl:for-each>
	</xsl:template>

<!--
Liste tous les intervenants
-->
	<xsl:template name="liste_des_intervenants">
		<div class="sous-titre-index">Liste des intervenants : </div>
		<ul> 
			<xsl:for-each select="intervenant">
				<xsl:variable name="id" select="intervenant"/>
				<li><a href="intervenant-{@id}.html">
					<xsl:value-of select="nom"/>
				</a></li>
			</xsl:for-each>
		</ul>
	</xsl:template>

<!--
Liste tous les parcours
-->
	<xsl:template name="liste_des_parcours">
		<div class="sous-titre-index">Liste des parcours : </div>
		<ul>
			<xsl:for-each select="parcours">
				<xsl:variable name="id" select="parcours"/>
					<li><a href="parcours-{@id}.html">
						<xsl:value-of select="nom"/>
					</a></li>
			</xsl:for-each>
		</ul>
	</xsl:template>

<!--
Liste de tous les unités
-->
	<xsl:template name="liste_des_unites">

		<div class="sous-titre-index">Liste des unités : </div>
		<ul>
			<xsl:for-each select="parcours/semestre/unite">
				<xsl:variable name="id" select="parcours/semestre/unite"/>
					<li><a href="unites-{@id}.html">
							<xsl:value-of select="nom"/>
					</a></li>
			</xsl:for-each>
		</ul>
	</xsl:template>

<!--
Liste les intervenants avec les détails de ces dernier
-->
	<xsl:template name="intervenants">
		<xsl:for-each select="intervenant">
			<xsl:call-template name="intervenant"/>
		</xsl:for-each>
	</xsl:template>

<!--
Détail d'un intervenant
-->
	<xsl:template name="intervenant">
		<div class="contour-intervenant">
			<ul>
				<li>id : <xsl:value-of select="@id"/></li>
				<li>nom : <xsl:value-of select="nom"/></li>
				<li>Email : <xsl:value-of select="mail"/></li>
				<li>Lien : <xsl:element name="a">
							<xsl:attribute name="href"><xsl:value-of select="web"/></xsl:attribute>
							<xsl:value-of select="web"/>
						</xsl:element></li>
			</ul>
		
			<xsl:call-template name="liste_des_unites_par_intervenant"/>
			<xsl:call-template name="liste_des_parcours_par_intervenant"/>
		</div>
	</xsl:template>

<!--
Liste les unitées enseignés pour chaque intervenant
-->
	<xsl:template name="liste_des_unites_par_intervenant">
		<div class="sous-titre-intervenants">Unité(s) enseignée(s) : </div>
			<xsl:element name="ol">
				<xsl:variable name="idInter" select="@id" />
				<xsl:for-each select="//unite">
					<xsl:variable name="NomUe" select="nom"/>
					<xsl:variable name="idUe" select="@id"/>

							<xsl:for-each select="./ref-intervenant">
								<xsl:variable name="inter" select="@ref"/>
								
								<xsl:if test="$idInter=$inter">
									<li>
										<a href="unites-{$idUe}.html">
											<xsl:value-of select="$NomUe"/>
										</a>
									</li>
								</xsl:if>
								
							</xsl:for-each>
						
				</xsl:for-each>
			</xsl:element>
	</xsl:template>

<!--
Liste les parcours dont les intervenant sont responsable
-->
	<xsl:template name="liste_des_parcours_par_intervenant">

		<div class="sous-titre-intervenants">Responsable du (des) parcours : </div>
		<xsl:element name="ol">
			<xsl:variable name="idInter" select="@id" />
			<xsl:for-each select="//parcours">
				<xsl:variable name="nomParcours" select="nom"/>
				<xsl:variable name="idParcours" select="@id"/>
					

						<xsl:for-each select="./ref-intervenant">
							<xsl:variable name="parcours" select="./ref-intervenant"/>
							<xsl:variable name="inter" select="@ref"/>
							
							<xsl:if test="$idInter=$inter">
								<li>
									<a href="parcours-{$idParcours}.html">
										<xsl:value-of select="$nomParcours"/>
									</a>
								</li>
							</xsl:if>
						
						</xsl:for-each>
	
				</xsl:for-each>
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
		<div class="contour-unite">
			<xsl:variable name="id" select="parcours/semestre/unite"/>
			<div class="sous-titre-intervenants" id="{@id}">
				Unité : <a href="unites-{@id}.html"><xsl:value-of select="nom"/></a> 
			</div>
			<p>
				id : <xsl:value-of select="@id"/><br/>
				unité : <xsl:value-of select="@role"/><br/>
				<xsl:if test="ref-intervenant">
					Enseignant(s) : 
					<ul><xsl:apply-templates select="ref-intervenant"/></ul>
				</xsl:if>
				Credits : <xsl:apply-templates select="nbCredits"/><br/>
				Résume : <br/><xsl:apply-templates select="resume"/><br/>
				Plan : <xsl:apply-templates select="plan"/><br/>
				Lieu : <xsl:apply-templates select="lieu"/><br />
					
				<xsl:call-template name="unite_appartenant_a_un_parcours"/>
						
			</p>
		</div>
	</xsl:template>


<!--
Liste tous les parcours avec les détails de ces dernier
-->	
	<xsl:template name="parcours">
	<h2>Parcours : <xsl:value-of select="nom"/></h2>
	<h3>Responsable(s) : </h3> <xsl:call-template name="intervenants"/>
	<xsl:call-template name="description"/>

	<xsl:apply-templates select="semestre"/>
	
	<xsl:call-template name="details_unites"/>
	
	<!--
	<xsl:call-template name="debouche"/>
-->
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
		
	<xsl:template name="unite_appartenant_a_un_parcours">
	
		<div class="sous-titre-index">Cette unité appartient au parcours : </div>
						
			<ul>
				<xsl:variable name="idUnite" select="@id" />
				<xsl:for-each select="//parcours">
					<xsl:variable name="nomParcours" select="nom"/>
					<xsl:variable name="idParcours" select="@id"/>
					
						<xsl:for-each select="./semestre/unite">
							<xsl:variable name="idUeCourante" select="@id"/>
								
								<xsl:if test="$idUnite=$idUeCourante">
									<li>
										<a href="parcours-{$idParcours}.html">
											<xsl:value-of select="$nomParcours"/>
										</a>
									</li>
								</xsl:if>
							
						</xsl:for-each>
						
					</xsl:for-each>

				</ul>

	</xsl:template>
	
	<xsl:template match="ref-intervenant">
			<li><a href="intervenant-{@ref}.html"><xsl:value-of select="@ref"/></a></li>
	</xsl:template>

	<xsl:template match="unite">
		<li><a href="unites-{@id}.html"><xsl:value-of select="@id"/></a></li>
	</xsl:template>

	<xsl:template match="semestre">
		<div class="sous-titre-intervenants">Semestre <xsl:value-of select="@numero"/> : </div>
		<ul><xsl:apply-templates select="unite"/></ul>
	</xsl:template>
		
	<xsl:template name="description">
		<p>
			<xsl:value-of select="description"/>
		</p>
	</xsl:template>

	<xsl:template name="debouche">
		<p>
			<xsl:value-of select="description"/>
		</p>
	</xsl:template>

	<xsl:template name="liste-des-UE-a-3-credits" >
<!--
		<xsl:param name="lieu" select="Luminy"/>
		<xsl:param name="nomUe" select="nom"/>
		<xsl:param name="nbCredits" select="3"/>
-->

		<xsl:variable name="nbCredits" select="nbCredits" />
		<xsl:variable name="lieu" select="lieu" />
		<xsl:variable name="nomUE" select="nom" />
		
		<xsl:if test="(($nbCredits=3) and ($lieu='Luminy'))">
			<li><a href="unites-{@id}.html"><xsl:value-of select="$nomUE" /></a></li>
		</xsl:if>

	</xsl:template>
		
	<xsl:template name="liste-des-intervenant-enseingant-luminy" >
<!--
		<xsl:param name="unite" />
-->
		
		<xsl:variable name="lieu" select="lieu" />
		<xsl:variable name="nomUE" select="nom" />
		
		<xsl:for-each select="./ref-intervenant">	
			<xsl:variable name="inter" select="@ref" />
			<xsl:if test="$lieu='Luminy'">
					<li>
						<xsl:value-of select="$inter" />
					</li>
			</xsl:if>
		</xsl:for-each>

	</xsl:template>


</xsl:stylesheet>

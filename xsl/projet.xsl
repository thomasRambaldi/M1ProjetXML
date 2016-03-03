<?xml version="1.0" encoding="UTF-8" ?>

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
			<xsl:document href="www/index.html" method="xml"
				encoding="UTF-8" indent="yes" doctype-public="//W3C//DTD XHTML 1.0 Strict//EN"
				doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
						<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css"/>
						<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css"/>
						<title>Index</title>
					</head>
					<body>

							
							<nav class="w3-sidenav w3-light-grey" style="width:10%">
							  <img src="../res/logo-sciences1.png" alt="logo-sciences" width="150" height="50" />	
							  <a href="intervenants.html">Liste des intervenants</a> <xsl:text> </xsl:text>
							  <a href="unites.html">Liste des unites</a>
							   <a href="parcours.html">Liste des parcours</a>
							  			
							</nav>
							<div id="main" style="margin-left:10%">

							<header class="w3-container w3-blue-grey">
							  <h1>Les masters de Luminy</h1>
							</header>		
							
							<div class="sous-titre-index">Liste des unités à 3 crédits se déroulant à Luminy : </div>
							
							<xsl:element name="ol">
								<xsl:for-each select="//unite">
										<xsl:call-template name="liste-des-UE-a-3-credits"/>
								</xsl:for-each>
							</xsl:element>

							<div class="sous-titre-index">Liste des intervenants enseignant qu'à Luminy : </div>
								<xsl:element name="ol">
									<xsl:for-each select="//unite">
										<xsl:call-template name="liste-des-intervenant-enseignant-luminy"/>
									</xsl:for-each>
								</xsl:element>
				
						<footer class="w3-container w3-blue-grey">
							<h5>Auteurs</h5>
							<p>Kévin Lebreton</p>
							<p>Thomas Rambaldi</p>
						</footer>
					</div>
					</body>
					
				</html>
			</xsl:document>
			
			<xsl:document href="www/intervenants.html" method="xml"
				encoding="UTF-8" indent="yes" doctype-public="//W3C//DTD XHTML 1.0 Strict//EN"
				doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
						<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css"/>
						<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css"/>
						<title>Intervenants</title>
					</head>
					<body>
						<nav class="w3-sidenav w3-light-grey" style="width:10%">
							  <img src="../res/logo-sciences1.png" alt="logo-sciences" width="150" height="50" />
							  <a href="index.html">Retour vers la page d'accueil</a> 
							  <a href="unites.html">Liste des unites</a>
							  <a href="parcours.html">Liste des parcours</a>				
							</nav>
							<div id="main" style="margin-left:10%">
						<div class="intervenants">
													<header class="w3-container w3-blue-grey">
							  <h1>Liste des intervenants</h1>
							</header>
							<xsl:call-template name="intervenants"/>
						</div>
						</div>
					</body>
				</html>
			</xsl:document>
						
			<xsl:document href="www/unites.html" method="xml"
				encoding="UTF-8" indent="yes" doctype-public="//W3C//DTD XHTML 1.0 Strict//EN"
				doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
						<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css"/>
						<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css"/>
						<title>Unites</title>
					</head>
					<body>
						<nav class="w3-sidenav w3-light-grey" style="width:10%">
							  <img src="../res/logo-sciences1.png" alt="logo-sciences" width="150" height="50" />
							  <a href="index.html">Retour vers la page d'accueil</a>
							  <a href="intervenants.html">Liste des intervenants</a>
							  <a href="parcours.html">Liste des parcours</a>				
						</nav>
						<div id="main" style="margin-left:10%">
						<div class="unites">
							<header class="w3-container w3-blue-grey">
							  <h1>Liste des unités</h1>
							
							</header>
							<xsl:call-template name="details_unites"/>
						</div>
						</div>
					</body>
				</html>
			</xsl:document>
			
			<xsl:document href="www/parcours.html" method="xml"
				encoding="UTF-8" indent="yes" doctype-public="//W3C//DTD XHTML 1.0 Strict//EN"
				doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
						<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css"/>
						<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css"/>
						<title>Unites</title>
					</head>
					<body>
						<nav class="w3-sidenav w3-light-grey" style="width:10%">
							  <img src="../res/logo-sciences1.png" alt="logo-sciences" width="150" height="50" />
							  <a href="index.html">Retour vers la page d'accueil</a>
							  <a href="intervenants.html">Liste des intervenants</a>
							  <a href="unites.html">Liste des unites</a>
						</nav>
						<div id="main" style="margin-left:10%">
						<div class="unites">
							<header class="w3-container w3-blue-grey">
							  <h1>Liste des parcours</h1>
							</header>
							<xsl:call-template name="details_parcours"/>
						</div>
						</div>
					</body>
				</html>
			</xsl:document>

			<xsl:call-template name="page_par_unite"/>
			<xsl:call-template name="page_par_intervenant"/>
			<xsl:call-template name="page_par_parcours"/>
	</xsl:template>

<!--
Crée une page par unité
-->
	<xsl:template name="page_par_unite">
			<xsl:for-each select="unite">
				<xsl:variable name="id" select="unite"/>
				<xsl:document href="www/unite-{@id}.html" method="xml"
				encoding="UTF-8" indent="yes" doctype-public="//W3C//DTD XHTML 1.0 Strict//EN"
				doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
						<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css"/>
						<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css"/>
						<title><xsl:value-of select="nom"/></title>
					</head>
					<body>
						<nav class="w3-sidenav w3-light-grey" style="width:10%">
							  <img src="../res/logo-sciences1.png" alt="logo-sciences" width="150" height="50" />
							  <a href="index.html">Retour vers la page d'accueil</a> <xsl:text> </xsl:text>
							  <a href="intervenants.html">Liste des intervenants</a> <xsl:text> </xsl:text>
							  <a href="unites.html">Liste des unites</a>
							  <a href="parcours.html">Liste des parcours</a>				
							</nav>
							<div id="main" style="margin-left:10%">
							<header class="w3-container w3-blue-grey">
							  <h2>Unite : <xsl:value-of select="nom"/></h2>
							</header>	
							<xsl:call-template name="details_unite"/>
						</div>
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
				<xsl:document href="www/intervenant-{@id}.html" method="xml"
				encoding="UTF-8" indent="yes" doctype-public="//W3C//DTD XHTML 1.0 Strict//EN"
				doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
						<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css"/>
						<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css"/>
						<title><xsl:value-of select="nom"/></title>
					</head>
					<body>
						<nav class="w3-sidenav w3-light-grey" style="width:10%">
							  <img src="../res/logo-sciences1.png" alt="logo-sciences" width="150" height="50" />
							  <a href="index.html">Retour vers la page d'accueil</a> <xsl:text> </xsl:text>
							  <a href="intervenants.html">Liste des intervenants</a> <xsl:text> </xsl:text>
							  <a href="unites.html">Liste des unites</a>
							  <a href="parcours.html">Liste des parcours</a>				
							</nav>
							<div id="main" style="margin-left:10%">
								<header class="w3-container w3-blue-grey">
							  <h2>Intervenant : <xsl:value-of select="nom"/></h2>
							</header>
						<xsl:call-template name="intervenant"/>
						</div>
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
			<xsl:document href="www/parcours-{@id}.html" method="xml"
				encoding="UTF-8" indent="yes" doctype-public="//W3C//DTD XHTML 1.0 Strict//EN"
				doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
			<html>
				<head>
					<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
					<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css"/>
						<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css"/>
					<title><xsl:value-of select="nom"/></title>
				</head>
				<body>
					<nav class="w3-sidenav w3-light-grey" style="width:10%">
							  <img src="../res/logo-sciences1.png" alt="logo-sciences" width="150" height="50" />	
							  <a href="index.html">Retour vers la page d'accueil</a> <xsl:text> </xsl:text>
							  <a href="intervenants.html">Liste des intervenants</a> <xsl:text> </xsl:text>
							  <a href="unites.html">Liste des unites</a>				
							  <a href="parcours.html">Liste des parcours</a>				
							</nav>
							<div id="main" style="margin-left:10%">
							<header class="w3-container w3-blue-grey">
							  <h2>Parcours : <xsl:value-of select="nom"/></h2>
							</header>
							<xsl:call-template name="parcours"/>
					</div>
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
				<xsl:for-each select="unite">
					<xsl:variable name="id" select="unite"/>
						<li><a href="unite-{@id}.html">
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
			<xsl:call-template name="liste_intervenant"/>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="liste_intervenant">
		<div class="contour-intervenant">
			<xsl:variable name="idInter" select="@id" />
			<ul>
				<li><a href="intervenant-{$idInter}.html"><xsl:value-of select="nom"/></a></li>
			</ul>
		</div>
	</xsl:template>
	
	
	<xsl:template name="ref-intervenants">
		<xsl:for-each select="ref-intervenant">
			<xsl:variable name="idInt" select="@ref"/>
			<li><a href="intervenant-{@ref}.html"><xsl:value-of select="//intervenant[@id=$idInt]/nom"/></a></li>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="affiche-intervenant-a-partir-de-ref">
		<xsl:variable name="refInter" select="@ref"/>
		<xsl:for-each select="//intervenant">
			<xsl:variable name="idInter" select="@id"/>
			
			<xsl:if test="$refInter=$idInter">
				<xsl:call-template name="link-name-intervenant"/>
			</xsl:if>
			
		</xsl:for-each>
	</xsl:template>

<!--
Détail d'un intervenant
-->
	<xsl:template name="intervenant">
		<div class="contour-intervenant">
			<xsl:variable name="idInter" select="@id" />
			<ul>
				<li>id : <xsl:value-of select="@id"/></li>
				<li>nom : <xsl:value-of select="nom"/></li>
				<li>Email : <xsl:value-of select="mail"/></li>
				<xsl:if test="web">
					<li>Lien : <xsl:element name="a">
							<xsl:attribute name="href"><xsl:value-of select="web"/></xsl:attribute>
							<xsl:value-of select="web"/>
						</xsl:element>
					</li>
				</xsl:if>		
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
									<a href="unite-{$idUe}.html">
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
		<xsl:for-each select="unite">
			<xsl:call-template name="listes_unite"/>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="listes_unite">
		<div class="contour-unite">
			<xsl:variable name="id" select="unite"/>
			<div class="sous-titre-intervenants" id="{@id}">
				<ul><li><a href="unite-{@id}.html"><xsl:value-of select="nom"/></a></li></ul> 
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="details_ref_unites">
		<xsl:for-each select="@ref">
			<xsl:call-template name="affiche-unite-a-partir-de-ref"/>
		</xsl:for-each>
	</xsl:template>
	
<!--
Détail d'une unité
-->
	<xsl:template name="details_unite">
		<div class="contour-unite">
			<xsl:variable name="id" select="unite"/>
				id : <xsl:value-of select="@id"/><br/>
				<xsl:if test="ref-intervenant">
					Enseignant(s) : 
					<ul><xsl:apply-templates select="ref-intervenant"/></ul>
				</xsl:if>
				Credits : <xsl:apply-templates select="nbCredits"/><br/>
				Résume : <br/><xsl:apply-templates select="resume"/><br/>
				<xsl:if test="plan">
					Plan : <xsl:value-of select="plan"/><br/>
				</xsl:if>
				<xsl:if test="lieu">
					Lieu : <xsl:call-template name="lieu"/><br />
				</xsl:if>	
				<xsl:call-template name="unite_appartenant_a_un_parcours"/>
		</div>
	</xsl:template>
	
	<xsl:template name="details_parcours">
		<xsl:for-each select="parcours">
			<xsl:call-template name="details_parcour"/>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="details_parcour">
		<div class="contour-unite">
			<xsl:variable name="id" select="unite"/>
			<div class="sous-titre-intervenants" id="{@id}">
				<ul><li><a href="parcours-{@id}.html"><xsl:value-of select="nom"/></a></li></ul>
			</div>
		</div>
	</xsl:template>

<!--
Liste tous les lieu de l'unité
-->
	<xsl:template name="lieu">
		<xsl:for-each select="lieu">
			<xsl:text> / </xsl:text> <xsl:value-of select="."/>
		</xsl:for-each>
	</xsl:template>

<!--
Liste tous les parcours avec les détails de ces dernier
-->	
	<xsl:template name="parcours">
		<h3>Responsable(s) : </h3> <xsl:call-template name="ref-intervenants"/>
		<xsl:call-template name="description"/>
		<xsl:call-template name="debouche"/>

		<xsl:apply-templates select="semestre"/>
	
		<xsl:call-template name="details_ref_unites"/>
	</xsl:template>
	
	<xsl:template name="unite_appartenant_a_un_parcours">
	
		<div class="sous-titre-index">Cette unité appartient au parcours : </div>
						
		<ul>
			<xsl:variable name="idUnite" select="@id" />
			<xsl:for-each select="//parcours">
				<xsl:variable name="nomParcours" select="nom"/>
				<xsl:variable name="idParcours" select="@id"/>
						<xsl:for-each select="./semestre/ref-unite">
							<xsl:variable name="idUeCourante" select="@ref"/>
								
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
	
	<xsl:template name="affiche-unite-a-partir-de-ref">
		<xsl:variable name="refUnite" select="@ref"/>
		<xsl:for-each select="unite">
			<xsl:variable name="idUnite" select="@id"/>
			<xsl:if test="$refUnite=$idUnite">
				<xsl:call-template name="details_unite"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="ref-intervenant">
			<li><a href="intervenant-{@ref}.html"><xsl:value-of select="@ref"/></a></li>
	</xsl:template>
	
	<xsl:template name="link-name-intervenant">
			<li><a href="intervenant-{@id}.html"><xsl:value-of select="nom"/></a></li>
	</xsl:template>
	
	<xsl:template match="ref-unite">
			<xsl:variable name="idUE" select="@ref"/>
			<li><a href="unite-{@ref}.html"><xsl:value-of select="//unite[@id=$idUE]/nom"/></a></li>
	</xsl:template>

	<xsl:template match="unite">
		<li><a href="unite-{@id}.html"><xsl:value-of select="@id"/></a></li>
	</xsl:template>

	<xsl:template match="semestre">
		<xsl:apply-templates select="description"/>
		<xsl:apply-templates select="debouche"/>
		<div class="sous-titre-intervenants">Semestre <xsl:value-of select="@numero"/> : </div>
		<ul><xsl:apply-templates select="ref-unite"/></ul>
	</xsl:template>
		
	<xsl:template name="description">
		<p>
			<xsl:value-of select="description"/>
		</p>
	</xsl:template>

	<xsl:template name="debouche">
		<p>
			<xsl:value-of select="debouche"/>
		</p>
	</xsl:template>

	<xsl:template name="liste-des-UE-a-3-credits" >
		<xsl:variable name="nbCredits" select="nbCredits" />
		<xsl:variable name="lieu" select="lieu" />
		<xsl:variable name="nomUE" select="nom" />
		<xsl:variable name="nblieux" select="count(./lieu)"/>
		<xsl:if test="(($nbCredits=3) and ($lieu='Luminy') and ($nblieux=1))">
			<li>
				<a href="unite-{@id}.html"><xsl:value-of select="$nomUE" /></a>
			</li>

		</xsl:if>

	</xsl:template>
		
	<xsl:template name="liste-des-intervenant-enseignant-luminy" >
		<xsl:variable name="nblieux" select="count(./lieu)"/>
		<xsl:variable name="lieu" select="lieu" />
		<xsl:for-each select="./ref-intervenant">	
			<xsl:variable name="inter" select="@ref" />
			<xsl:if test="$lieu='Luminy'and $nblieux=1" >
				<li>
					<a href="intervenant-{$inter}.html"><xsl:value-of select="$inter" /></a>
				</li>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>


</xsl:stylesheet>

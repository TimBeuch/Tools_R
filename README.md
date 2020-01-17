---
title: "Untitled"
output: 
  html_document:
    keep_md: true
---



# Preambule

Ce package rassemble des fonctions qui me sont utiles au quotidien.

# Fonction resume

La fonction resume permet de présenter un grand nombre d'information pour un vecteur/dataframe. C'est une sorte de summary améliorer. 

la fonction resume indique :
* le nom de la variable
* son type
* son effectif
* son effectif de non réponse
* son nombre de réponse unique
* son mode
* sa valeur minimum
* sa valeur maximal
* sa moyenne
* son écart-type
* son premier quartil
* sa médianne
* son troisième quartile
* son cinquième percentile
* son quatre-vingt quinzième percentile
* la médianne de la longueur des occurences


```r
# devtools::install_github("TimBeuch/Tools_R")
pacman::p_load(EZtools,
               dplyr)

iris %>% resume
```

```
## # A tibble: 5 x 17
##   name  type      n n_missing n_unique mode  pct_mode min   max   mean  sd   
##   <chr> <chr> <int>     <int>    <int> <chr> <chr>    <chr> <chr> <chr> <chr>
## 1 Sepa… nume…   150         0       35 5     6.7      4.3   7.9   5.8   0.83 
## 2 Sepa… nume…   150         0       23 3     17       2     4.4   3.1   0.44 
## 3 Peta… nume…   150         0       43 1.4   8.7      1     6.9   3.8   1.8  
## 4 Peta… nume…   150         0       22 0.2   19       0.1   2.5   1.2   0.76 
## 5 Spec… fact…   150         0        3 seto… 33       <NA>  <NA>  <NA>  <NA> 
## # … with 6 more variables: quart25 <chr>, median <chr>, quart75 <chr>,
## #   cent05 <chr>, cent95 <chr>, med_length <chr>
```

On peut spécifier les colonnes à resume.


```r
iris %>% resume(Sepal.Length,
                Sepal.Width)
```

```
## # A tibble: 2 x 17
##   name  type      n n_missing n_unique mode  pct_mode min   max   mean  sd   
##   <chr> <chr> <int>     <int>    <int> <chr> <chr>    <chr> <chr> <chr> <chr>
## 1 Sepa… nume…   150         0       35 5     6.7      4.3   7.9   5.8   0.83 
## 2 Sepa… nume…   150         0       23 3     17       2     4.4   3.1   0.44 
## # … with 6 more variables: quart25 <chr>, median <chr>, quart75 <chr>,
## #   cent05 <chr>, cent95 <chr>, med_length <chr>
```

Note : Si plusieurs valeurs correspond au mode d'une variable alors resume renvoi la première occurences des différents modes. De plus, les variables caractères renvoie des NA aux différents agrégats numériques.

# Fonction Mode(s)

La fonction mode_stat renvoi le mode d'une variable.


```r
iris$Species %>% mode_stat()
```

```
## [1] setosa
## Levels: setosa versicolor virginica
```

La fonction modes_stat renvois les modes d'une variable s'il y a plusieurs occurences.


```r
iris$Species %>% modes_stat()
```

```
## [1] setosa     versicolor virginica 
## Levels: setosa versicolor virginica
```

# Fonction I

La fonction I met en forme les modalité numérique pour les faire correspondre aux critères français.


```r
t = c(1258112.3,.31,114711654,12.32155489)

t %>% I(digits = 2)
```

```
## [1] "1 258 112.3" "0.31"        "114 711 654" "12.32"
```


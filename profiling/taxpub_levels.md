# TaxPub data levels
(need be properly written)
## treatment level 1
[definition](https://github.com/plazi/ggxml2taxpub-treatments/issues/21)
treatment-meta
- mixed-citation, including
-- treatment title tagged as named-content
-- zenodo treatment DOI and treatmentbank uri tagged as uri
-- parent publication article-title
-- parent publication doi tagged as uri
treatment
- nomenclature
- - name
treatment-sec (with uncontrolled sec-types taken verbatim from source ggxml)

at the phrase level inside treatment secs, taxon names and material-citation strings are encoded.

A formal expression of the de fact schema from the markup in the current 500 instance sample is:

```
default namespace = ""
namespace tp = "http://www.plazi.org/taxpub"

start =
  element tp:taxon-treatment {
    element tp:treatment-meta {
      element mixed-citation {
        element named-content {
          attribute content-type { xsd:NCName },
          text
        },
        (element article-title { text }
         | element uri {
             attribute content-type { xsd:NCName },
             xsd:anyURI
           })+
      }
    },
    element tp:nomenclature { taxon-name },
    treatment-sec*
  }
taxon-name = element tp:taxon-name { text }
treatment-sec =
  element tp:treatment-sec {
    attribute sec-type { xsd:NCName },
    (treatment-sec
     | element p {
         (text
          | taxon-name
          | element tp:material-citation { (text | taxon-name)+ })+
       })*
  }
  ```
## treatment level 2
(to be decided)

same as level-1 
- attributes
- details of material citations (see also [MIDS](https://github.com/plazi/ggxml2taxpub-treatments/blob/main/tdwg%20MIDS%20levels%20for%20specimens.md) for digital specimen)

## treatment level 3
(to be decided)

same as level 2
- treatment citations

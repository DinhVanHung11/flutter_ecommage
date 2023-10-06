const String queryCategories = """
  query getCategories(\$level: String!, \$id: String!) {
    categoryList(filters: {ids: {in: [\$level, \$id]}}) {
      children_count
      children {
        id
        level
        name
        path
        url_path
        url_key
        image
        description
        children {
          id
          level
          name
          path
          url_path
          url_key
          image
          description
        }
      }
    }
  }
""";

const queryCategoryById = '''
  query getCategory(\$id: Int!, \$currentPage: Int!){
    category(id: \$id) {
      name
      products(currentPage: \$currentPage) {
        total_count
        page_info {
          current_page
          page_size
        }
        items{
          id
          sku
          name
          stock_status
          image{
              url
              label
          },
          price_range{
              minimum_price{
                regular_price{
                    value
                    currency
                }
                final_price{
                    value
                    currency
                }
              },
              maximum_price{
                regular_price{
                    value,
                    currency
                }
                final_price{
                    value
                    currency
                }
              }
          }
        }
      }
    }
  }
''';

const queryProductSku = '''
  query getProduct(\$sku: String!){
    products(filter: { sku: { eq: \$sku } }) {
      items {
        __typename
        id
        sku
        name
        image{
          url
          label
          position
        }
        description {
          html
        }
        short_description {
          html
        }
        price_range{
          maximum_price{
            regular_price{
              value
              currency
            }
            final_price{
              value
              currency
            }
          }
        }
        special_price
        reviews{
          items{
            average_rating
            summary
            text
            created_at
            nickname
          }
        }
        related_products {
          id
          sku
          stock_status
          short_description {
            html
          }
          __typename
          image{
            url
            label
            position
          }
          url_key
          name
          special_price
          price_range {
            minimum_price {
              final_price {
                value
                currency
              }
            }
            maximum_price {
              regular_price{
                value
                currency
              }
              final_price {
                value
                currency
              }
            }
          }
        }
        ... on ConfigurableProduct {
        configurable_options {
          id
          attribute_id
          label
          position
          use_default
          attribute_code
          values {
            value_index
            label
            swatch_data{
              value
            }
          }
            product_id
          }
          variants {
            product {
              id
              name
              sku
              attribute_set_id
              ... on PhysicalProductInterface {
                weight
              }
              price_range{
                minimum_price{
                  regular_price{
                    value
                    currency
                  }
                }
              }
            }
            attributes {
              label
              code
              value_index
            }
          }
        }
        media_gallery {
          url
          label
          position
          disabled
          ... on ProductVideo {
            video_content {
              media_type
              video_provider
              video_url
              video_title
              video_description
              video_metadata
            }
          }
        }
      }
    }
  }
''';

const queryOnlyCmsBlock = '''
  query queryOnlyCmsBlock(\$identify: String!){
    cmsBlocks(identifiers: \$identify) {
      items {
        identifier
        title
        content
      }
    }
  }
''';
// ignore_for_file: constant_identifier_names

const CreateCustomer = '''
  mutation CreateCustomer(\$firstname: String, \$lastname: String,\$email: String!,\$password: String!) {
    createCustomer(
      input: {
        firstname: \$firstname
        lastname: \$lastname
        email: \$email
        password: \$password
        is_subscribed: true
      }
    ) {
      customer {
        firstname
        lastname
        email
        is_subscribed
      }
    }
  }
''';

const CreateEmptyCart = '''
  mutation {
    createEmptyCart
  }
''';

const AddSimpleProductToCart = '''
  mutation AddSimpleProductToCart(\$cartId: String!, \$qty: Float!, \$sku: String!){
    addSimpleProductsToCart(
      input: {
        cart_id: \$cartId
        cart_items: [
          {
            data: {
              quantity: \$qty
              sku: \$sku
            }
          }
        ]
      }
    ) {
      cart {
        items {
          id
          product {
            sku
            stock_status
          }
          quantity
        }
      }
    }
  }
''';

const AddConfigruationProductToCart = '''
  mutation AddConfigruationProductToCart(\$cartId: String!, \$qty: Float!, \$parentSku: String!, \$sku: String!){
    addConfigurableProductsToCart(
      input: {
        cart_id: \$cartId
        cart_items: [
          {
            parent_sku: \$parentSku
            data: {
              quantity: \$qty
              sku: \$sku
            }
          }
        ]
      }
    ) {
      cart {
        items {
          uid
          quantity
          product {
            name
            sku
          }
          ... on ConfigurableCartItem {
            configurable_options {
              option_label
            }
          }
        }
      }
    }
  }
''';

const CreateProductReview = '''
  mutation CreateProductReview(\$sku: String!, \$nickname: String!, \$summary: String!, \$text: String!){
    createProductReview(
      input: {
        sku: \$sku,
        nickname: \$nickname,
        summary: \$summary,
        text: \$text,
        ratings: [
          {
            id: "NA==",
            value_id: "MTk="
          }, {
            id: "MQ==",
            value_id: "NA=="
          }, {
            id: "Mg==",
            value_id: "OA=="
          }
        ]
      }
  ) {
      review {
        nickname
        summary
        text
        average_rating
        ratings_breakdown {
          name
          value
        }
      }
    }
  }
''';
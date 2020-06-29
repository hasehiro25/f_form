# frozen_string_literal: true

class TokenGenerator
  ALGORITHM = "SHA256"

  def initialize(klass, column, algorithm: "SHA256")
    @klass = klass
    @column = column
    @algorithm = algorithm
  end

  def digest(value)
    value.present? && OpenSSL::HMAC.hexdigest(@algorithm, key, value)
  end

  def generate
    loop do
      raw = friendly_token
      enc = digest(raw)
      break [raw, enc] unless @klass.exists?({ @column => enc })
    end
  end

  private
    def key
      "fformkey#{@column}"
    end

    def friendly_token(length = 20)
      SecureRandom.urlsafe_base64(length * 3 / 4).tr("lIO0", "sxyz")
    end
end

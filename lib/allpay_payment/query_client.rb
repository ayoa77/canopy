require "digest"
require "uri"
require "net/http"
require "net/https"
require "json"
require "date"
require "allpay_payment/helper"
require "allpay_payment/verification"
require "allpay_payment/error"
require "allpay_payment/core_ext/hash"
require "allpay_payment/core_ext/string"
# require "helper"
# require "verification"
# require "error"
# require "core_ext/hash"
# require "core_ext/string"

module AllpayPayment

  class QueryClient

    def initialize
      @helper = APIHelper.new
      #@verify_query_api = QueryTradeInfoParamVerify.new

    end

    def query_trade_info(param)
      query_base_proc!(params: param)
      unix_time = get_curr_unix_time() + 120
      param['TimeStamp'] = unix_time.to_s
      p param['TimeStamp']
      res = query_pos_proc!(params: param, apiname: 'QueryTradeInfo')
      return res
    end

    def query_credit_period(param)
      query_base_proc!(params: param)
      unix_time = get_curr_unix_time() + 120
      param['TimeStamp'] = unix_time.to_s
      p param['TimeStamp']
      param.delete('PlatformID')
      res = query_pos_proc!(params: param, apiname: 'QueryCreditCardPeriodInfo')
      return res
    end

    def query_transac_csv(param)
      query_base_proc!(params: param)
      param.delete('PlatformID')
      res = query_pos_proc!(params: param, apiname: 'TradeNoAio', big5_trans: true)
      return res
    end

    def query_credit_single(param)
      query_base_proc!(params: param)
      param.delete('PlatformID')
      res = query_pos_proc!(params: param, apiname: 'QueryTradeV2')
      return res
    end

    def query_credit_csv(param)
      query_base_proc!(params: param)
      param.delete('PlatformID')
      res = query_pos_proc!(params: param, apiname: 'FundingReconDetail')
      return res
    end



    ### Private method definition start ###
    private

      def get_curr_unix_time()
        return Time.now.to_i
      end

      def query_base_proc!(params:)
        if params.is_a?(Hash)
          # Transform param key to string
          params.stringify_keys()

          if @helper.is_contractor?
            params['PlatformID'] = @helper.get_mercid
            if params['MerchantID'].nil?
              raise "[MerchantID] should be specified when you're contractor-Platform."
            end
          else
            params['PlatformID'] = ''
            params['MerchantID'] = @helper.get_mercid
          end
        else
          raise InvalidParam, "Recieved parameter object must be a Hash"
        end
      end

      def query_pos_proc!(params:, apiname:, big5_trans:false)
        verify_query_api = QueryParamVerify.new(apiname)
        verify_query_api.verify_query_param(params)
        #encode special param

        # Insert chkmacval
        chkmac = @helper.gen_chk_mac_value(params)
        params['CheckMacValue'] = chkmac
        # gen post html
        api_url = verify_query_api.get_svc_url(apiname, @helper.get_op_mode)
        #post from server
        resp = @helper.http_request(method: 'POST', url: api_url, payload: params)

        # return  post response
        if big5_trans
          return resp.encode('utf-8', 'big5')
        else
          return resp
        end
      end
    ### Private method definition end ###

  end
end

          





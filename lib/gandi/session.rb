module Gandi
  
  class Session
    HOST = "https://api.gandi.net/xmlrpc/"
    
    attr_reader :handler, :session_id

    def initialize(login, password, host, safe_mode = true)
      @login     = login
      @password  = password
      @host      = host
      @safe_mode = safe_mode
    end
    
    def connect
      @handler    = XMLRPC::Client.new2(@host)
      @session_id = call("login", @login, @password, @safe_mode)
    end
    alias login connect
    
    def call(*args)
      raise LoadError, "no connexion handler is set." unless @handler.is_a?(XMLRPC::Client)
      @handler.call(*args)
    rescue XMLRPC::FaultException => exception
      raise ( exception.faultCode < 500000 ? Gandi::ServerError : Gandi::DataError ), exception.faultString
    end
    
    def method_missing(method, *args)
      if %w(password account_currency account_balance domain_list domain_available domain_lock domain_unlock domain_info domain_renew domain_create domain_restore domain_del domain_transfer_in_available domain_transfer_in domain_transfer_out domain_trade domain_change_owner domain_change_contact domain_ns_list domain_ns_add domain_ns_del domain_ns_set host_list host_info host_create host_delete domain_gandimail_activate domain_gandimail_deactivate domain_forward_list domain_forward_set domain_forward_delete domain_mailbox_list domain_mailbox_info domain_mailbox_add domain_mailbox_update domain_mailbox_delete domain_mailbox_alias_list domain_mailbox_alias_set domain_mailbox_purge domain_web_redir_list domain_web_redir_add domain_web_redir_del contact_create contact_update contact_del contact_info operation_list operation_details operation_relaunch operation_cancel tld_list).include?(method.to_s)
        call(method, @session_id, *args)
      else
        raise NoMethodError, "method #{method} is not available in the GANDI API."
      end
    end
    
    # Accepted arguments are:
    # :host, :login, :password and :safe_mode (defaults to true)
    def self.connect(*args)
      config = { :host => HOST, :safe_mode => true }.merge(args.extract_options!)
      unless config[:login] && config[:password]
        raise ArgumentError, "login and password needed"
      end
      client = self.new(config[:login], config[:password], config[:host], config[:safe_mode])
      client.connect
      return client
    end
  end
end
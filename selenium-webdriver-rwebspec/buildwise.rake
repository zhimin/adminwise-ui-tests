require 'httpclient'
require 'net/http'
require 'yaml'
gem 'ci_reporter'
require 'ci/reporter/rake/rspec' # use this if you're using RSpec

def buildwise_start_build(options)
  options[:stage] ||= "Acceptance"
  the_response_content = contact_buildwise_post("/builds/begin", "options" => YAML.dump(options))
  new_build_id = the_response_content
end

def buildwise_finish_build(build_id)
  puts "[buildwise.rake] Finishing build: #{build_id}"
  if build_id && (build_id.class == Fixnum  || build_id =~ /\d+/)
    pdata = {
      "id" =>  build_id,
      "stage" => "Functional"
    }   
    
    notify_url = "/async/builds/finish/#{build_id}"
    if RUBY_PLATFORM =~ /darwin/
        notify_url = "/builds/finish/#{build_id}"
    end
    
    outcome = contact_buildwise_get(notify_url)    
    puts "[buildwise.rake] #{notify_url} => #{outcome}"
    return outcome
  end
end

def buildwise_build_status(build_id)
  return contact_buildwise_get("/builds/status/#{build_id}")
end

def buildwise_build_ui_test_status(build_id)
  if RUBY_PLATFORM =~ /darwin/
      return contact_buildwise_get("/builds/ui_test_status/#{build_id}")
  else
      return contact_buildwise_get("/async/builds/ui_test_status/#{build_id}")
  end  
end

def buildwise_build_failed(build_id)
  failed_files = contact_buildwise("/builds/failures/#{build_id}?stage=Functional") if build_id && build_id =~ /\d+/
  failed_file_list = failed_files.split(",")
end

# Check the builder order for this project
#
# @params: project_identifier, a string unique identifier
def buildwise_ui_test_order(project_identifier)
  puts "Check test order: #{project_identifier}"
  if project_identifier
    ui_test_in_order = contact_buildwise_get("/projects/ui_test_priority/#{project_identifier}")
		return nil if ui_test_in_order.nil? || ui_test_in_order.include?("502 Bad Gateway") 
    puts "Get test order: #{ui_test_in_order}"
    ui_test_in_order.split(",")  rescue nil
  else
    return nil
  end
end


def contact_buildwise_get(path)
  begin
    client = HTTPClient.new
    the_res = client.get("#{BUILDWISE_URL}#{path}").body
		if the_res.respond_to?("content")
			the_res = the_res.content			
		end    
		return nil if the_res.include?("Internal Server Error")
    return the_res
  rescue => e
    puts "error to contact BAM with GET:  #{e}"
    return nil
  end
end

def contact_buildwise_post(path, pdata)
  begin
    url = "#{BUILDWISE_URL}#{path}"
    puts "  [buildwise.rake] Posting to |#{url}|"
    response = HTTPClient.new.post(url, pdata)
    the_res = response.body 
		if the_res.respond_to?("content")
			the_res = the_res.content			
		end    
		return the_res
  rescue => e
    puts "error to contact BAM with POST:  #{e}"
    return nil
  end
end

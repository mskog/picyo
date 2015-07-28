# require 'spec_helper'

# describe ImageUploadJob do
#   Given(:url){'http://www.example.com'}
#   Given(:params){{url: url}}
#   Given!(:double){instance_double(Services::CreateImage)}
#   Given!(:create_image){class_double(Services::CreateImage).as_stubbed_const}

#   Given{allow(create_image).to receive(:new).with(params).and_return(double)}
#   Given{expect(double).to receive(:perform)}

#   subject{described_class.new(params)}

#   When{subject.perform(params)}
#   Then{}
# end

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails3_pg_deferred_constraints/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails3_pg_deferred_constraints"
  s.version     = Rails3PgDeferredConstraints::VERSION
  s.authors     = ["Potapov Sergey", "TMX Credit"]
  s.email       = ["blake131313@gmail.com"]
  s.homepage    = "https://github.com/greyblake/rails3_pg_deferred_constraints"
  s.summary     = "Rails 3 engine which provides a hack to avoid RI_ConstraintTrigger Error bug"
  s.description = "Rails 3 engine which provides a hack to avoid RI_ConstraintTrigger Error bug"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.0"
  s.add_dependency "pg"

  s.add_development_dependency "foreigner"
end

#def bundle

#  extra_excluded_groups = ['cucumber']

#  if File.exist?("#{c.release_path}/Gemfile")
#    info "~> Gemfile detected, bundling gems (customised)"
#    lockfile = File.join(c.release_path, "Gemfile.lock")

#    bundler_installer = if File.exist?(lockfile)
#                          get_bundler_installer(lockfile, " #{extra_excluded_groups.join(' ')}")
#                        else
#                          missing_lock_version = EY::Serverside::LockfileParser::Parse10::DEFAULT
#                          warn_about_missing_lockfile missing_lock_version
#                          bundler_10_installer missing_lock_version
#                        end

#    sudo "#{serverside_bin} _#{EY::Serverside::VERSION}_ install_bundler #{bundler_installer.version}"

#    bundled_gems_path = File.join(c.shared_path, "bundled_gems")
#    ruby_version_file = File.join(bundled_gems_path, "RUBY_VERSION")
#    system_version_file = File.join(bundled_gems_path, "SYSTEM_VERSION")
#    ruby_version = `ruby -v`
#    system_version = `uname -m`

#    if File.directory?(bundled_gems_path)
#      rebundle = false

#      rebundle = true if File.exist?(ruby_version_file) && File.read(ruby_version_file) != ruby_version
#      rebundle = true if File.exist?(system_version_file) && File.read(system_version_file) != system_version

#      if rebundle
#        info "~> Ruby version change detected, cleaning bundled gems"
#        run "rm -Rf #{bundled_gems_path}"
#      end
#    end

#    run "cd #{c.release_path} && bundle _#{bundler_installer.version}_ install #{bundler_installer.options}"

#    run "mkdir -p #{bundled_gems_path} && ruby -v > #{ruby_version_file} && uname -m > #{system_version_file}"
#  end
#end

def bundler_10_installer(version, options = '')
  default_options = "--deployment --path #{c.shared_path}/bundled_gems --binstubs #{c.binstubs_path} --without development test cucumber"
  BundleInstaller.new(version, default_options + options)
end

class Target < ISM::Software
    
    def configure
        super

        if option("Pass1")
            configureSource(arguments:  "--prefix=/usr                       \
                                        --host=#{Ism.settings.chrootTarget} \
                                        --build=#{Ism.settings.systemTarget}",
                            path:       buildDirectoryPath)
        else
            configureSource(arguments:      "--prefix=/usr",
                            path:           buildDirectoryPath,
                            environment:    {"FORCE_UNSAFE_CONFIGURE" => "1"})
        end
    end
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource( arguments:  "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)
    end

end

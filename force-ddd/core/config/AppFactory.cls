public class AppFactory {
    
    public class ServiceFactory {

        private Map<Type,Type> serviceInterfaceByImplementationMap;
        private Map<Type,Object> serviceInterfaceByMockMap;

        public ServiceFactory(Map<Type,Type> serviceInterfaceByImplementationMap) {
            this.serviceInterfaceByImplementationMap = serviceInterfaceByImplementationMap;
            this.serviceInterfaceByMockMap = new Map<Type,Object>();
        }

        public Object newInstance(Type serviceInterfaceType) {
            if(serviceInterfaceByMockMap.containsKey(serviceInterfaceType)) {
                return serviceInterfaceByMockMap.get(serviceInterfaceType);
            }
            return serviceInterfaceByImplementationMap.get(serviceInterfaceType).newInstance();
        }

        @TestVisible
		private void setMock(Type serviceInterfaceType, Object serviceImpl) {
			serviceInterfaceByMockMap.put(serviceInterfaceType, serviceImpl);
		}

    }

    public class RepositoryFactory {

        private Map<Type,Type> repositoryInterfaceByImplementationMap;
        private Map<Type,Object> repositoryInterfaceByMockMap;

        public RepositoryFactory(Map<Type,Type> repositoryInterfaceByImplementationMap) {
            this.repositoryInterfaceByImplementationMap = repositoryInterfaceByImplementationMap;
            this.repositoryInterfaceByMockMap = new Map<Type,Object>();
        }

        public Object newInstance(Type repositoryInterfaceType) {
            if(repositoryInterfaceByMockMap.containsKey(repositoryInterfaceType)) {
                return repositoryInterfaceByMockMap.get(repositoryInterfaceType);
            }
            return repositoryInterfaceByImplementationMap.get(repositoryInterfaceType).newInstance();
        }

        public void setDependency(Type repositoryInterfaceType, Type repositoryImplType) {
            repositoryInterfaceByImplementationMap.put(repositoryInterfaceType, repositoryImplType);
        }

        @TestVisible
		private void setMock(Type repositoryInterfaceType, Object repositoryImpl) {
			repositoryInterfaceByMockMap.put(repositoryInterfaceType, repositoryImpl);
		}

    }

    public class DomainFactory {

        private Map<Type,Type> domainInterfaceByImplementationMap;
        private Map<Type,Object> domainInterfaceByMockMap;

        public DomainFactory(Map<Type,Type> domainInterfaceByImplementationMap) {
            this.domainInterfaceByImplementationMap = domainInterfaceByImplementationMap;
            this.domainInterfaceByMockMap = new Map<Type,Object>();
        }

        public Object newInstance(Type domainInterfaceType) {
            if(domainInterfaceByMockMap.containsKey(domainInterfaceType)) {
                return domainInterfaceByMockMap.get(domainInterfaceType);
            }
            return domainInterfaceByImplementationMap.get(domainInterfaceType).newInstance();
        }

        @TestVisible
		private void setMock(Type domainInterfaceType, Object domainImpl) {
			domainInterfaceByMockMap.put(domainInterfaceType, domainImpl);
		}

    }

    public class UnitOfWorkFactory {
        
        private UnitOfWork uowMock;

        public UnitOfWorkFactory() {}

        public UnitOfWork newInstance() {
            if (uowMock != null) {
                return uowMock;
            }
            return new UnitOfWorkImpl();
        }

        @TestVisible
        private void setMock(UnitOfWork uowMock) {
            this.uowMock = uowMock;
        }
    }

}
